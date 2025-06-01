import 'package:dartz/dartz.dart';

import '../../../../core/error/app_exception.dart';
import '../../data/models/login_data_model.dart';

class LogInState {
  final bool isLoading;
  final Either<AppException, LoginDataModel>? data;
  LogInState({this.isLoading = false, this.data});

  LogInState copyWith({
    bool? isLoading,
    final Either<AppException, LoginDataModel>? data,
  }) {
    return LogInState(isLoading: isLoading ?? this.isLoading, data: data);
  }
}

