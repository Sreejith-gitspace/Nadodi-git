import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../widgets/place_card.dart';
import 'place_detail_screen.dart';

class DistrictExplorerScreen extends StatelessWidget {
  static const routeName = '/district-explorer';

  const DistrictExplorerScreen({super.key});

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
              child: Text('Top attractions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            if (data.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (data.error != null)
              Expanded(child: Center(child: Text(data.error!)))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: data.places.length,
                  itemBuilder: (context, index) {
                    final place = data.places[index];
                    return PlaceCard(
                      place: place,
                      onTap: () => Navigator.pushNamed(
                        context,
                        PlaceDetailScreen.routeName,
                        arguments: place,
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
