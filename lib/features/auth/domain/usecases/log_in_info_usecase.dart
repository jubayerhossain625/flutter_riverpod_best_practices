import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import '../../data/models/login_data_model.dart';
import '../../data/models/sign_up_req_model.dart';
import '../../data/repositories_impl/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

class LogInInfoUseCase {
  final AuthRepository repository;

  LogInInfoUseCase(this.repository);

  Future<Either<AppException, LoginDataModel>> execute(
    SignUpReqModel signUpReqModel, {
    required List<File> files,
  }) {
    return repository.logInInfoSubmit(
      signUpReqModel,
      files: files,
      fileKey: "userPhoto",
    );
  }
}

final loginInfoSubmitUseCaseProvider = Provider<LogInInfoUseCase>((ref) {
  return LogInInfoUseCase(ref.read(authRepositoryProvider));
});

