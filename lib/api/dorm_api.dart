import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rehaish_app/models/dorm.dart';
import '../config/constants.dart';

class DormApi {
  static const int maxRetries = 3;

  static Future<List<Map<String, dynamic>>> getDorms() async {
    int retryCount = 0;
    const initialRetryDelay = Duration(seconds: 2);

    while (retryCount < maxRetries) {
      final response =
          await http.get(Uri.parse('${Constants.baseUrl}/dorms/all'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.isEmpty) {
          throw Exception('API returned empty or null data');
        }
        return jsonResponse.cast<Map<String, dynamic>>();
      } else if (response.statusCode == 429) {
        print('Too many requests, retrying after delay...');
        retryCount++;
        await Future.delayed(initialRetryDelay * retryCount);
      } else {
        throw Exception('Failed to load dorms');
      }
    }
    throw Exception('Max retries exceeded, failed to load dorms');
  }

  static Future<Dorm> getDormById(String id) async {
    final response =
        await http.get(Uri.parse('${Constants.baseUrl}/dorms/$id'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Dorm.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load dorm details');
    }
  }

}
