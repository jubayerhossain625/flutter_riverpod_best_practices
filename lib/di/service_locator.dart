import 'package:flutter_riverpod_best_practices/core/common/services/location_service.dart';
import 'package:flutter_riverpod_best_practices/core/utils/validators.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register Repository
  getIt.registerLazySingleton<LocationService>(() => LocationService());

  //Register Validators
  getIt.registerLazySingleton<Validators>(() => Validators());
}
