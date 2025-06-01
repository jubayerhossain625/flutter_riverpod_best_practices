import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/app_exception.dart';

class LocationState {
  final bool isLoading;
  final Either<AppException, ({Position position, String address})>? data;
  LocationState({this.isLoading = false, this.data});

  LocationState copyWith({
    bool? isLoading,
    final Either<AppException, ({Position position, String address})>? data,
  }) {
    return LocationState(isLoading: isLoading ?? this.isLoading, data: data);
  }
}

