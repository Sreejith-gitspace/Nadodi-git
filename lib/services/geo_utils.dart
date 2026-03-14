import 'dart:math';

double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadiusKm = 6371.0;
  final dLat = _degreeToRadian(lat2 - lat1);
  final dLon = _degreeToRadian(lon2 - lon1);
  final a = pow(sin(dLat / 2), 2) +
      cos(_degreeToRadian(lat1)) * cos(_degreeToRadian(lat2)) * pow(sin(dLon / 2), 2);
  final c = 2 * asin(min(1, sqrt(a)));
  return earthRadiusKm * c;
}

double _degreeToRadian(double degree) => degree * pi / 180;
