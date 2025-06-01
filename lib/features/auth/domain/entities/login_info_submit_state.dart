import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exception.dart';
import '../../data/models/login_data_model.dart';

class LoginInfoSubmitState {
  final bool isLoading;
  final Either<AppException, LoginDataModel>? data;
  LoginInfoSubmitState({this.isLoading = false, this.data});

  LoginInfoSubmitState copyWith({
    bool? isLoading,
    final Either<AppException, LoginDataModel>? data,
  }) {
    return LoginInfoSubmitState(isLoading: isLoading ?? this.isLoading, data: data);
  }
}

