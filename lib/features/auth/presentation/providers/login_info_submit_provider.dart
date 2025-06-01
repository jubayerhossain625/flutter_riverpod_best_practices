import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/common/providers/location_provider.dart';
import '../../data/models/sign_up_req_model.dart';
import '../../domain/entities/login_info_submit_state.dart';
import '../../domain/usecases/log_in_info_usecase.dart';

class LoginInfoSubmitNotifier extends Notifier<LoginInfoSubmitState> {
  @override
  build() {
    return LoginInfoSubmitState();
  }

  Future<void> submitLogInInfo({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required List<File> files,
  }) async {
    final SignUpReqModel signUpReqModel = SignUpReqModel(
      fullName: fullName,
      email: email,
      phone: phone,
      address: address,
      latitude: 0.0,
      longitude: 0.0,
    );
    state = state.copyWith(isLoading: true, data: null);
    final locatinData = ref.read(locationProvider);
    if (locatinData.data != null) {
      //if location data is found
      final useCase = ref.read(loginInfoSubmitUseCaseProvider);

      SignUpReqModel signUpReqData = locatinData.data!.fold(
        (l) => signUpReqModel, //if location error no need to update position
        (r) => signUpReqModel.copyWith(
          latitude: r.position.latitude,
          longitude: r.position.longitude,
        ),
      );

      final result = await useCase.execute(signUpReqData, files: files);
      state = state.copyWith(isLoading: false, data: result);
    } else {
      //Trying
      ref.read(locationProvider.notifier).refreshLocation();
      ref.listen(locationProvider, (pre, next) async {
        //Trying to get position info
        if (next.isLoading) {
          if (!state.isLoading) {
            state = state.copyWith(isLoading: true, data: null);
          }
        } else {
          //Trying end, even not getting data i have to continue login info submit.

          if (next.data != null) {
            final useCase = ref.read(loginInfoSubmitUseCaseProvider);

            SignUpReqModel signUpReqData = next.data!.fold(
              (l) =>
                  signUpReqModel, //if location error no need to update position
              (r) => signUpReqModel.copyWith(
                latitude: r.position.latitude,
                longitude: r.position.longitude,
              ),
            );

            final result = await useCase.execute(signUpReqData, files: files);
            state = state.copyWith(isLoading: false, data: result);
          }
        }
      });
    }
  }
}

final loginInfoSubmitProvider =
    NotifierProvider<LoginInfoSubmitNotifier, LoginInfoSubmitState>(
      () => LoginInfoSubmitNotifier(),
    );
