import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import '../../data/models/login_data_model.dart';
import '../../data/models/sign_up_req_model.dart';

abstract class AuthRepository {
  Future<Either<AppException, LoginDataModel>> login(String phone);
  Future<Either<AppException, LoginDataModel>> verifyOTP(
    String phone,
    String? otp,
    String? hash,
  );
  Future<Either<AppException, LoginDataModel>> logInInfoSubmit(
    SignUpReqModel signUpReqModel, {
    required List<File> files,
    required String fileKey,
  });
}
