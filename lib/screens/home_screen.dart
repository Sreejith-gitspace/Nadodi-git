import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/data_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/place_card.dart';
import 'district_explorer_screen.dart';
import 'hidden_spots_screen.dart';
import 'ai_travel_assistant_screen.dart';
import 'map_explorer_screen.dart';
import 'place_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const List<Widget> _screens = [
    DistrictExplorerScreen(),
    HiddenSpotsScreen(),
    AITravelAssistantScreen(),
    MapExplorerScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);

    dataProvider.loadPlaces();
    dataProvider.loadHiddenSpots();
    dataProvider.loadRestaurants();
    dataProvider.loadHotels();
    locationProvider.loadCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final data = Provider.of<DataProvider>(context);
    final location = Provider.of<LocationProvider>(context);

    final nearbyPlaces = location.currentPosition != null
        ? data.getNearbyPlaces(location.currentPosition!)
        : <dynamic>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nadodi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.signOut();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (nearbyPlaces.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              width: double.infinity,
              color: Colors.green.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nearby suggestions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nearbyPlaces.length.clamp(0, 8),
                      itemBuilder: (context, index) {
                        final place = nearbyPlaces[index];
                        return SizedBox(
                          width: 240,
                          child: PlaceCard(
                            place: place,
                            onTap: () {
                              Navigator.pushNamed(context, PlaceDetailScreen.routeName, arguments: place);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
