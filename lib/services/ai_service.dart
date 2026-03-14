import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants.dart';

class AiService {
  AiService._();

  static final AiService instance = AiService._();

  Future<String> ask(String prompt) async {
    final apiUrl = Uri.parse('${AppConstants.apiBaseUrl}/ai/chat');
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'prompt': prompt}),
    );

    if (response.statusCode != 200) {
      throw Exception('OpenAI request failed (${response.statusCode})');
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    return body['data'] as String? ?? '';
  }
}
