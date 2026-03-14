import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService._();

  static final LocationService instance = LocationService._();

  Future<bool> requestPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final asked = await Geolocator.requestPermission();
      return asked == LocationPermission.always || asked == LocationPermission.whileInUse;
    }
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  Future<Position> getCurrentPosition() async {
    if (!await requestPermission()) {
      throw Exception('Location permission denied');
    }
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
