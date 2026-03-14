import '../models/fuel_station.dart';

class FuelService {
  FuelService._();

  static final FuelService instance = FuelService._();

  List<FuelStation> fetchNearbyFuelStations() {
    // This is a static sample list. In a real implementation, this would call an API.
    return [
      FuelStation(
        id: 'fuel_1',
        name: 'Kerala Fuel Station',
        latitude: 9.9312,
        longitude: 76.2673,
        address: 'Main Road, Kochi',
      ),
      FuelStation(
        id: 'fuel_2',
        name: 'GreenFuel Pump',
        latitude: 8.5241,
        longitude: 76.9366,
        address: 'Beach Road, Thiruvananthapuram',
      ),
      FuelStation(
        id: 'fuel_3',
        name: 'Hilltop Fuel Station',
        latitude: 10.0874,
        longitude: 77.0594,
        address: 'Munnar Road, Idukki',
      ),
    ];
  }
}
