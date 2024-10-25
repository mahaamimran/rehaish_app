import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class DormApi {
  static const String baseUrl = 'http://192.168.18.187:3000/api/v1';
  static const int maxRetries = 3;

  static Future<List<Map<String, dynamic>>> getDorms() async {
    int retryCount = 0;
    const initialRetryDelay = Duration(seconds: 2);

    while (retryCount < maxRetries) {
      final response = await http.get(Uri.parse('$baseUrl/dorms/all'));

      // Log the status code and the body of the response
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse.isEmpty) {
          throw Exception('API returned empty or null data');
        }

        return jsonResponse.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 429) {
        // Handle rate-limiting by retrying with exponential backoff
        print('Too many requests, retrying after delay...');
        retryCount++;
        await Future.delayed(initialRetryDelay * retryCount); // Exponential backoff
      } else {
        // Log error and throw exception
        throw Exception('Failed to load dorms');
      }
    }

    throw Exception('Max retries exceeded, failed to load dorms');
  }
}
