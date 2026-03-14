import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ai_provider.dart';

class AITravelAssistantScreen extends StatefulWidget {
  static const routeName = '/ai-assistant';

  const AITravelAssistantScreen({super.key});

  @override
  State<AITravelAssistantScreen> createState() => _AITravelAssistantScreenState();
}

class _AITravelAssistantScreenState extends State<AITravelAssistantScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ai = Provider.of<AiProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('AI Travel Assistant', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (ai.isLoading)
                        const LinearProgressIndicator()
                      else if (ai.error != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(ai.error!, style: const TextStyle(color: Colors.red)),
                        ),
                      if (ai.response.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(ai.response, style: const TextStyle(fontSize: 16, height: 1.4)),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ask about places, hotels, or plan a trip...',
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: ai.isLoading
                        ? null
                        : () {
                            final prompt = _controller.text.trim();
                            if (prompt.isEmpty) return;
                            ai.ask(prompt);
                          },
                    child: const Icon(Icons.send),
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
