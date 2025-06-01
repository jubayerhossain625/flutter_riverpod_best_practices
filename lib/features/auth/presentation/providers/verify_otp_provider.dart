import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/features/auth/domain/entities/verify_otp_state.dart';
import '../../../../core/common/providers/auth_notifier.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

class VerifyOTPNotifier extends Notifier<VerifyOtpState> {
  @override
  build() {
    return VerifyOtpState();
  }

  Future<void> verifyOTP(String phone, String otp, String hash) async {
    state = state.copyWith(isLoading: true, data: null);
    final useCase = ref.read(verifyOtpUseCaseProvider);
    final result = await useCase.execute(phone, otp, hash);
    result.fold((l) {}, (r) async {
      final authNotifier = ref.read(authNotifierProvider.notifier);
      authNotifier.saveLogin(
        userId: r.userId!,
        accessToken: r.accessToken!,
        refreshToken: r.refreshToken!,
        phoneNumber: phone
      );
    });
    state = state.copyWith(isLoading: false, data: result);
  }
}

final verifyOtpProvider = NotifierProvider<VerifyOTPNotifier, VerifyOtpState>(
  () => VerifyOTPNotifier(),
);
