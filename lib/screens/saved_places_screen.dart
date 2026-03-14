import 'package:flutter/material.dart';

class SavedPlacesScreen extends StatelessWidget {
  static const routeName = '/saved-places';

  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for saved places implementation
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Places')),
      body: const Center(child: Text('Your saved places will appear here.')),
    );
  }
}
