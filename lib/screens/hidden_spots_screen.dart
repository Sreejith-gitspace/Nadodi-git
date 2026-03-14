import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../widgets/place_card.dart';
import 'place_detail_screen.dart';

class HiddenSpotsScreen extends StatelessWidget {
  static const routeName = '/hidden-spots';

  const HiddenSpotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Hidden spots', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            if (data.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (data.error != null)
              Expanded(child: Center(child: Text(data.error!)))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: data.hiddenSpots.length,
                  itemBuilder: (context, index) {
                    final spot = data.hiddenSpots[index];
                    return PlaceCard(
                      place: spot,
                      onTap: () => Navigator.pushNamed(
                        context,
                        PlaceDetailScreen.routeName,
                        arguments: spot,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
