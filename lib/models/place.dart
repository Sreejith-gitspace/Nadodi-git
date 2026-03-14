import 'dart:convert';

class Place {
  final String id;
  final String name;
  final String description;
  final String district;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final List<String> tags;
  final bool isHidden;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.tags,
    required this.isHidden,
  });

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['_id']?.toString() ?? map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      district: map['district'] ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      isHidden: map['isHidden'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'district': district,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrl': imageUrl,
      'tags': tags,
      'isHidden': isHidden,
    };
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));
}
