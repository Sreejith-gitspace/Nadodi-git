class AiPromptTemplates {
  static String planTrip({
    required String startLocation,
    required int days,
    required double budget,
    required String travelStyle,
  }) {
    return '''
You are a helpful travel planner for Kerala, India.
Create a detailed ${days}-day itinerary starting from "$startLocation" for a $travelStyle trip with a budget of ₹${budget.toStringAsFixed(0)}.
Include daily highlights, recommended restaurants, hotels/homestays, and approximate cost breakdown per day.
Provide routes and suggested travel durations.
''';
  }
}
