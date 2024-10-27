import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/constants.dart';

class AuthApi {
  static const storage = FlutterSecureStorage();

  // Get token from secure storage
  static Future<String?> getToken() async {
    return await storage.read(key: 'jwtToken');
  }

  // Get user ID from secure storage
  static Future<String?> getUserId() async {
    return await storage.read(key: 'userId');
  }

  // Save token and user ID to secure storage
  static Future<void> saveTokenAndUserId(String token, String userId) async {
    await storage.write(key: 'jwtToken', value: token);
    await storage.write(key: 'userId', value: userId);
  }

  // Delete token and user ID from secure storage
  static Future<void> clearTokenAndUserId() async {
    await storage.delete(key: 'jwtToken');
    await storage.delete(key: 'userId');
  }

  // Login API request
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/users/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Fetch user profile by user ID
  static Future<Map<String, dynamic>> fetchUserProfile(String userId, String token) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/users/$userId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch user profile');
    }
  }
}
