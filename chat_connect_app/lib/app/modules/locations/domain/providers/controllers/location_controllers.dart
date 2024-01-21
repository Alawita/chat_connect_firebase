import 'package:chat_connect_app/app/modules/locations/domain/repo/location_repo.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends ChangeNotifier {
  double _lat = 0.0;
  double _long = 0.0;

  double get lat => _lat;
  double get long => _long;

  Future<void> checkLocationPermission() async {
    LocationPermission hasLocationPermission =
        await Geolocator.requestPermission();
    if (hasLocationPermission.name == LocationPermission.whileInUse.name ||
        hasLocationPermission.name == LocationPermission.always.name) {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    _lat = position.latitude;
    _long = position.longitude;
    locationRepo.updateUserLocation(_lat, _long);
    notifyListeners();
  }
}
