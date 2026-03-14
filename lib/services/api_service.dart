import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../core/constants.dart';
import '../models/place.dart';
import '../models/trip_plan.dart';

class ApiService {
  ApiService._();

  static final ApiService instance = ApiService._();

  Uri _buildUri(String path, [Map<String, String>? queryParameters]) {
    return Uri.parse('${AppConstants.apiBaseUrl}$path').replace(queryParameters: queryParameters);
  }

  Future<List<Place>> fetchPlaces({String? district, bool hiddenOnly = false}) async {
    final query = <String, String>{};
    if (district != null && district.isNotEmpty) query['district'] = district;
    if (hiddenOnly) query['hidden'] = 'true';

    final response = await http.get(_buildUri('/places', query));
    if (response.statusCode != 200) {
      throw Exception('Failed to load places: ${response.statusCode}');
    }

    final payload = json.decode(response.body) as Map<String, dynamic>;
    final items = List<Map<String, dynamic>>.from(payload['data'] as List);
    return items.map((it) => Place.fromMap(it)).toList();
  }

  Future<List<Place>> fetchHiddenSpots({String? district}) async {
    return fetchPlaces(district: district, hiddenOnly: true);
  }

  Future<List<Place>> fetchRestaurants({String? district}) async {
    final response = await http.get(_buildUri('/restaurants', {'district': district ?? ''}));
    if (response.statusCode != 200) {
      throw Exception('Failed to load restaurants');
    }
    final payload = json.decode(response.body) as Map<String, dynamic>;
    final items = List<Map<String, dynamic>>.from(payload['data'] as List);
    return items.map((it) => Place.fromMap(it)).toList();
  }

  Future<List<Place>> fetchHotels({String? district}) async {
    final response = await http.get(_buildUri('/hotels', {'district': district ?? ''}));
    if (response.statusCode != 200) {
      throw Exception('Failed to load hotels');
    }
    final payload = json.decode(response.body) as Map<String, dynamic>;
    final items = List<Map<String, dynamic>>.from(payload['data'] as List);
    return items.map((it) => Place.fromMap(it)).toList();
  }

  Future<TripPlan> createTripPlan({
    required String startLocation,
    required int days,
    required double budget,
    required String travelStyle,
    required String userId,
  }) async {
    final body = {
      'startLocation': startLocation,
      'days': days,
      'budget': budget,
      'travelStyle': travelStyle,
      'userId': userId,
    };

    final response = await http.post(
      _buildUri('/ai-trip-plan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create trip plan: ${response.statusCode}');
    }

    final payload = json.decode(response.body) as Map<String, dynamic>;
    return TripPlan.fromMap(payload['data'] as Map<String, dynamic>);
  }
}
