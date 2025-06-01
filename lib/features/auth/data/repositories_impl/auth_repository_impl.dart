import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import 'package:flutter_riverpod_best_practices/features/auth/data/models/login_data_model.dart';
import 'package:flutter_riverpod_best_practices/features/auth/data/models/sign_up_req_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppException, LoginDataModel>> login(String phone) async {
    final response = await remoteDataSource.login(
      LoginRequestModel(phone: phone),
    );

    //print(response.fold((l) => "Error: ${l.parseError()}", (r) => "Right: ${r.toString()}"));

    return response.fold((leftData) => left(leftData), (rightData) {
      return right(LoginDataModel.fromJson(rightData));
    });
  }

  @override
  Future<Either<AppException, LoginDataModel>> verifyOTP(
    String phone,
    String? otp,
    String? hash,
  ) async {
    final response = await remoteDataSource.login(
      LoginRequestModel(phone: phone, otp: otp, hash: hash),
    );
    return response.fold((leftData) => left(leftData), (rightData) {

      
      return right(LoginDataModel.fromJson(rightData));
    });
  }

  @override
  Future<Either<AppException, LoginDataModel>> logInInfoSubmit(
    SignUpReqModel signUpReqModel, {
    required List<File> files,
    required String fileKey,
  }) async {
    final response = await remoteDataSource.loginInfoSubmnit(
      signUpReqModel,
      files: files,
      fileKey: fileKey,
    );
    return response.fold((leftData) => left(leftData), (rightData) {
      return right(LoginDataModel.fromJson(rightData));
    });
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider)),
);

