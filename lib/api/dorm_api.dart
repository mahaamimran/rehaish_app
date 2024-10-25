import 'dart:convert';
import 'package:http/http.dart' as http;

class DormApi {
  static const String baseUrl = 'http://localhost:3000/api/v1';  // Your API URL

  // Fetch dorms from the API
  static Future<List<dynamic>> getDorms() async {
    final response = await http.get(Uri.parse('$baseUrl/dorms/all'));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return the list of dorms
    } else {
      throw Exception('Failed to load dorms');
    }
  }
}
