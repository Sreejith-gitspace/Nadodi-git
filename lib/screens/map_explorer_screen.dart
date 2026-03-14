import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../providers/location_provider.dart';
import '../services/fuel_service.dart';

class MapExplorerScreen extends StatefulWidget {
  static const routeName = '/map-explorer';

  const MapExplorerScreen({super.key});

  @override
  State<MapExplorerScreen> createState() => _MapExplorerScreenState();
}

class _MapExplorerScreenState extends State<MapExplorerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = Provider.of<LocationProvider>(context, listen: false);
      location.loadCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);
    final location = Provider.of<LocationProvider>(context);

    final fuelStations = FuelService.instance.fetchNearbyFuelStations();

    final markers = <Marker>{
      for (final place in data.places)
        Marker(
          markerId: MarkerId(place.id),
          position: LatLng(place.latitude, place.longitude),
          infoWindow: InfoWindow(title: place.name, snippet: place.district),
        ),
      for (final station in fuelStations)
        Marker(
          markerId: MarkerId(station.id),
          position: LatLng(station.latitude, station.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: station.name, snippet: station.address),
        ),
    };

    return Scaffold(
      body: Stack(
        children: [
          if (location.currentPosition != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(location.currentPosition!.latitude, location.currentPosition!.longitude),
                zoom: 11,
              ),
              markers: markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            )
          else
            const Center(child: CircularProgressIndicator()),
          Positioned(
            top: 20,
            right: 16,
            child: ElevatedButton.icon(
              onPressed: () async {
                await location.loadCurrentLocation();
              },
              icon: const Icon(Icons.my_location),
              label: const Text('My Location'),
              style: ElevatedButton.styleFrom(elevation: 4),
            ),
          ),
        ],
      ),
    );
  }
}
