import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exception.dart';
import '../../data/models/login_data_model.dart';

class VerifyOtpState {
  final bool isLoading;
  final Either<AppException, LoginDataModel>? data;
  VerifyOtpState({this.isLoading = false, this.data});

  VerifyOtpState copyWith({
    bool? isLoading,
    final Either<AppException, LoginDataModel>? data,
  }) {
    return VerifyOtpState(isLoading: isLoading ?? this.isLoading, data: data);
  }
}

