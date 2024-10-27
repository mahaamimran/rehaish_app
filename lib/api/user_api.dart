import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/constants.dart';

class UserApi {
  static const storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await storage.read(key: 'jwtToken');
  }

  static Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  static Future<List<dynamic>> getBookmarks() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/users/bookmarks'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load bookmarks');
    }
  }

  static Future<void> addBookmark(String dormId) async {
    final token = await getToken();

    final response = await http.patch(
      Uri.parse('${Constants.baseUrl}/users/bookmark'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode({"dormId": dormId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to bookmark dorm');
    }
  }

  static Future<void> removeBookmark(String dormId) async {
    final token = await getToken();

    final response = await http.patch(
      Uri.parse('${Constants.baseUrl}/users/unbookmark'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode({"dormId": dormId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to unbookmark dorm');
    }
  }
}
