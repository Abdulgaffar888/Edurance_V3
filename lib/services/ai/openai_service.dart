import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  // Read API key from environment variables
  // To set it up:
  // Run with: flutter run --dart-define=OPENAI_API_KEY=your_new_api_key_here
  static const String _apiKey = String.fromEnvironment('OPENAI_API_KEY', 
    defaultValue: ''
  );
  
  static const String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  /// Check if API key is configured
  static bool get isConfigured => _apiKey.isNotEmpty;

  /// Send a message to OpenAI and get response
  static Future<String> sendMessage(String message) async {
    if (!isConfigured) {
      throw Exception('OpenAI API key not configured. Please add --dart-define=OPENAI_API_KEY=your_key');
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': message},
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error calling OpenAI: $e');
    }
  }

  /// Send a conversation history to OpenAI
  static Future<String> sendConversation(List<Map<String, String>> messages) async {
    if (!isConfigured) {
      throw Exception('OpenAI API key not configured. Please add --dart-define=OPENAI_API_KEY=your_key');
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error calling OpenAI: $e');
    }
  }
}