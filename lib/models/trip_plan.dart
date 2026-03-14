class TripPlan {
  final String id;
  final String title;
  final String description;
  final int days;
  final double budget;
  final String travelStyle;
  final List<TripDay> daysPlan;

  TripPlan({
    required this.id,
    required this.title,
    required this.description,
    required this.days,
    required this.budget,
    required this.travelStyle,
    required this.daysPlan,
  });

  factory TripPlan.fromMap(Map<String, dynamic> map) {
    return TripPlan(
      id: map['_id']?.toString() ?? map['id']?.toString() ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      days: map['days'] ?? 0,
      budget: (map['budget'] as num?)?.toDouble() ?? 0,
      travelStyle: map['travelStyle'] ?? '',
      daysPlan: (map['daysPlan'] as List<dynamic>? ?? [])
          .map((e) => TripDay.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

class TripDay {
  final int dayNumber;
  final String summary;
  final List<TripStop> stops;

  TripDay({
    required this.dayNumber,
    required this.summary,
    required this.stops,
  });

  factory TripDay.fromMap(Map<String, dynamic> map) {
    return TripDay(
      dayNumber: map['dayNumber'] ?? 0,
      summary: map['summary'] ?? '',
      stops: (map['stops'] as List<dynamic>? ?? [])
          .map((e) => TripStop.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

class TripStop {
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String type;

  TripStop({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.type,
  });

  factory TripStop.fromMap(Map<String, dynamic> map) {
    return TripStop(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0,
      type: map['type'] ?? '',
    );
  }
}
