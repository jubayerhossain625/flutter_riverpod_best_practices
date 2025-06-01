import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod_best_practices/core/common/entities/location_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/location_service.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

class LocationNotifer extends Notifier<LocationState> {
  @override
  LocationState build() {
    return LocationState();
  }

  Future<void> refreshLocation() async {
    final service = ref.read(locationServiceProvider);
    final position = await service.getCurrentPosition();
    final address = await service.getAddressFromCoordinates(position);
    state = LocationState(
      isLoading: false,
      data: right((position: position, address: address)),
    );
  }
}

final locationProvider = NotifierProvider<LocationNotifer, LocationState>(
  () => LocationNotifer(),
);
