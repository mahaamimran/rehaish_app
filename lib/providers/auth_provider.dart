import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/user_api.dart';
import '../config/constants.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  String? _token;
  User? currentUser;

  String? get token => _token;

  AuthProvider() {
    _initializeAuth(); // Initialize authentication on app startup
  }

  Future<void> _initializeAuth() async {
    // Load token and user ID from local storage
    _token = await UserApi.getToken();
    final userId = await UserApi.getUserId();

    print('Loaded token: $_token, userId: $userId'); // Debugging
    
    // If token and userId are found, try to fetch the user profile
    if (_token != null && userId != null) {
      await _fetchUserProfile(userId);
    }
    notifyListeners();
  }

  Future<void> _fetchUserProfile(String userId) async {
    if (_token == null) return; // If no token, skip fetching

    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/users/$userId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
      );

      print("Profile fetch status: ${response.statusCode}");
      print("Profile fetch body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        currentUser = User.fromJson(responseData['user']);
        notifyListeners();
      } else {
        print("Failed to fetch profile. Status: ${response.statusCode}, Body: ${response.body}");
        throw Exception('Failed to fetch user profile');
      }
    } catch (error) {
      print("Profile loading error: $error");
      await logout(); // Clear local storage if fetching profile fails
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/users/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      print("Login response status: ${response.statusCode}");
      print("Login response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token'];
        final userData = responseData['savedUserWithoutPassword'];
        currentUser = User.fromJson(userData);

        // Save token and user ID to secure storage
        await storage.write(key: 'jwtToken', value: _token);
        await storage.write(key: 'userId', value: currentUser!.id);

        notifyListeners();
      } else {
        throw Exception('Failed to login');
      }
    } catch (error) {
      print("Login error: $error");
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    currentUser = null;
    await storage.delete(key: 'jwtToken');
    await storage.delete(key: 'userId');
    notifyListeners();
  }

  bool isLoggedIn() => _token != null;
}
