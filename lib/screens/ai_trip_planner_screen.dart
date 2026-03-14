import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';
import '../providers/auth_provider.dart';

class AITripPlannerScreen extends StatefulWidget {
  static const routeName = '/ai-trip-planner';

  const AITripPlannerScreen({super.key});

  @override
  State<AITripPlannerScreen> createState() => _AITripPlannerScreenState();
}

class _AITripPlannerScreenState extends State<AITripPlannerScreen> {
  final _locationController = TextEditingController();
  final _daysController = TextEditingController(text: '3');
  final _budgetController = TextEditingController(text: '15000');
  String _travelStyle = 'solo';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final ai = Provider.of<AiProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Trip Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Starting location'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _daysController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Days'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _budgetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Budget (₹)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Travel style:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _travelStyle,
                  items: const [
                    DropdownMenuItem(value: 'solo', child: Text('Solo')),
                    DropdownMenuItem(value: 'family', child: Text('Family')),
                    DropdownMenuItem(value: 'friends', child: Text('Friends')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _travelStyle = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: ai.isLoading
                  ? null
                  : () async {
                      final days = int.tryParse(_daysController.text) ?? 3;
                      final budget = double.tryParse(_budgetController.text) ?? 15000;
                      await ai.createTripPlan(
                        startLocation: _locationController.text.trim(),
                        days: days,
                        budget: budget,
                        travelStyle: _travelStyle,
                        userId: auth.user?.uid ?? '',
                      );
                    },
              child: ai.isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Generate Plan'),
            ),
            const SizedBox(height: 20),
            if (ai.currentTripPlan != null)
              Expanded(
                child: ListView.builder(
                  itemCount: ai.currentTripPlan!.daysPlan.length,
                  itemBuilder: (context, index) {
                    final day = ai.currentTripPlan!.daysPlan[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Day ${day.dayNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(day.summary),
                            const SizedBox(height: 10),
                            ...day.stops.map(
                              (stop) => ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.place_outlined),
                                title: Text(stop.name),
                                subtitle: Text(stop.description),
                              ),
                            )
                          ],
                        ),
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
