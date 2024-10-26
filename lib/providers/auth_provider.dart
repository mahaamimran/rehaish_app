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

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/users/login'), // Update this if necessary
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _token = responseData['token'];
        await storage.write(key: 'jwtToken', value: _token);
        print("Login successful, token stored: $_token"); // Debugging
        notifyListeners();
      } else {
        print("Login failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception('Failed to login');
      }
    } catch (error) {
      print("Login error: $error");
      rethrow;
    }
  }


  Future<void> logout() async {
    _token = null;
    await storage.delete(key: 'jwtToken');
    notifyListeners();
  }

  Future<void> loadToken() async {
    _token = await storage.read(key: 'jwtToken');
    notifyListeners();
  }

  bool isLoggedIn() => _token != null;

}
