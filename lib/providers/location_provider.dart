import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? currentPosition;
  bool isLoading = false;
  String? error;

  Future<void> loadCurrentLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      currentPosition = await LocationService.instance.getCurrentPosition();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
