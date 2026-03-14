import 'package:flutter/material.dart';

import '../services/ai_service.dart';
import '../services/api_service.dart';
import '../models/trip_plan.dart';

class AiProvider extends ChangeNotifier {
  String response = '';
  bool isLoading = false;
  String? error;

  TripPlan? currentTripPlan;

  Future<void> ask(String question) async {
    isLoading = true;
    notifyListeners();

    try {
      response = await AiService.instance.ask(question);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTripPlan({
    required String startLocation,
    required int days,
    required double budget,
    required String travelStyle,
    required String userId,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      currentTripPlan = await ApiService.instance.createTripPlan(
        startLocation: startLocation,
        days: days,
        budget: budget,
        travelStyle: travelStyle,
        userId: userId,
      );
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
