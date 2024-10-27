import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/constants.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  String? _token;
  User? currentUser;

  String? get token => _token;

  AuthProvider() {
    _loadTokenAndUser(); // Load token and user on startup
  }

  Future<void> _loadTokenAndUser() async {
    _token = await storage.read(key: 'jwtToken');
    final userId = await storage.read(key: 'userId');
    if (_token != null && userId != null) {
      await _fetchUserProfile(userId); // Load user profile if token exists
    }
    notifyListeners();
  }

  Future<void> _fetchUserProfile(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('${Constants.baseUrl}/users/$userId'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        currentUser = User.fromJson(responseData['user']);
        notifyListeners();
      } else {
        print(
            "Failed to fetch profile. Status: ${response.statusCode}, Body: ${response.body}");
        throw Exception('Failed to fetch user profile');
      }
    } catch (error) {
      print("Profile loading error: $error");
      await logout();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/users/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token'];
        currentUser = User.fromJson(responseData['user']); // Set currentUser

        // Save token and user ID
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
