import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/features/auth/domain/entities/log_in_state.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginNotifier extends Notifier<LogInState> {
  @override
  build() {
    return LogInState();
  }

  Future<void> login(String phone,[ String? otp, String? hash]) async {
    state = state.copyWith(isLoading: true, data: null);
    final useCase = ref.read(loginUseCaseProvider);
    final result = await useCase.execute(phone);
    state = state.copyWith(isLoading: false, data: result);
  }
  

}

final loginProvider = NotifierProvider<LoginNotifier, LogInState>(
  () => LoginNotifier(),
);
