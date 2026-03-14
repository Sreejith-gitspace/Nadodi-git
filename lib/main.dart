import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/auth_provider.dart';
import 'providers/data_provider.dart';
import 'providers/ai_provider.dart';
import 'providers/location_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/district_explorer_screen.dart';
import 'screens/place_detail_screen.dart';
import 'screens/hidden_spots_screen.dart';
import 'screens/ai_travel_assistant_screen.dart';
import 'screens/ai_trip_planner_screen.dart';
import 'screens/saved_places_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/map_explorer_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  runApp(const NadodiApp());
}

class NadodiApp extends StatelessWidget {
  const NadodiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => AiProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          return MaterialApp(
            title: 'Nadodi Smart Travel',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
            routes: {
              LoginScreen.routeName: (_) => const LoginScreen(),
              HomeScreen.routeName: (_) => const HomeScreen(),
              DistrictExplorerScreen.routeName: (_) => const DistrictExplorerScreen(),
              PlaceDetailScreen.routeName: (_) => const PlaceDetailScreen(),
              HiddenSpotsScreen.routeName: (_) => const HiddenSpotsScreen(),
              AITravelAssistantScreen.routeName: (_) => const AITravelAssistantScreen(),
              AITripPlannerScreen.routeName: (_) => const AITripPlannerScreen(),
              SavedPlacesScreen.routeName: (_) => const SavedPlacesScreen(),
              ProfileScreen.routeName: (_) => const ProfileScreen(),
              MapExplorerScreen.routeName: (_) => const MapExplorerScreen(),
            },
          );
        },
      ),
    );
  }
}
