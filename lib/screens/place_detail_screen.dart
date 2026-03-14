import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: place.id,
              child: Image.network(
                place.imageUrl,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 240,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, size: 72, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(place.district, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 16),
                  Text(place.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                  const Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(place.latitude, place.longitude),
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId(place.id),
                          position: LatLng(place.latitude, place.longitude),
                          infoWindow: InfoWindow(title: place.name),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
