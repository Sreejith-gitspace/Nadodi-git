import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../models/place.dart';
import '../services/api_service.dart';
import '../services/geo_utils.dart';

class DataProvider extends ChangeNotifier {
  List<Place> places = [];
  List<Place> hiddenSpots = [];
  List<Place> restaurants = [];
  List<Place> hotels = [];
  bool isLoading = false;
  String? error;

  List<Place> getNearbyPlaces(Position position, {double radiusKm = 10}) {
    return places
        .where((place) =>
            haversineDistance(position.latitude, position.longitude, place.latitude, place.longitude) <=
            radiusKm)
        .toList();
  }

  Future<void> loadPlaces({String? district}) async {
    isLoading = true;
    notifyListeners();
    try {
      places = await ApiService.instance.fetchPlaces(district: district);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHiddenSpots({String? district}) async {
    isLoading = true;
    notifyListeners();
    try {
      hiddenSpots = await ApiService.instance.fetchHiddenSpots(district: district);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRestaurants({String? district}) async {
    isLoading = true;
    notifyListeners();
    try {
      restaurants = await ApiService.instance.fetchRestaurants(district: district);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHotels({String? district}) async {
    isLoading = true;
    notifyListeners();
    try {
      hotels = await ApiService.instance.fetchHotels(district: district);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
