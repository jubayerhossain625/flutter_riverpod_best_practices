import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_best_practices/core/error/app_exception.dart';
import 'package:flutter_riverpod_best_practices/core/network/api_service.dart';
import 'package:flutter_riverpod_best_practices/features/auth/data/models/sign_up_req_model.dart';

import '../../../../core/network/api_providers.dart';
import '../models/login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<AppException, Map<String, dynamic>>> login(
    LoginRequestModel request,
  );
  Future<Either<AppException, Map<String, dynamic>>> loginInfoSubmnit(
    SignUpReqModel signUpReqModel, {
    required List<File> files,
    required String fileKey,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<Either<AppException, Map<String, dynamic>>> login(
    LoginRequestModel request,
  ) async {
    return await apiService.postRequest("/auth/sign-in", {
      "phone": request.phone,
      if (request.otp != null) "otp": request.otp,
      if (request.hash != null) "hash": request.hash,
    });
  }

  @override
  Future<Either<AppException, Map<String, dynamic>>> loginInfoSubmnit(
    SignUpReqModel signUpReqModel, {
    required List<File> files,
    required String fileKey,
  }) async {
    return await apiService.postMultipartRequest(
      "/auth/sign-up",
      files: files,
      fileKey: fileKey,
      fields: signUpReqModel.toJson(),
    );
  }
}


final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(ref.read(apiServiceProvider)),
);