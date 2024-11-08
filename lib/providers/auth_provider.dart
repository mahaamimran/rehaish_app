import 'package:flutter/material.dart';
import '../api/auth_api.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  User? currentUser;

  String? get token => _token;

  AuthProvider() {
    _initializeAuth(); // Initialize authentication on app startup
  }

  Future<void> _initializeAuth() async {
    // Load token and user ID from local storage
    _token = await AuthApi.getToken();
    final userId = await AuthApi.getUserId();

    // print('Loaded token: $_token, userId: $userId'); // Debugging

    // If token and userId are found, try to fetch the user profile
    if (_token != null && userId != null) {
      await _fetchUserProfile(userId);
    }
    notifyListeners();
  }

  Future<void> _fetchUserProfile(String userId) async {
    if (_token == null) return;

    try {
      final responseData = await AuthApi.fetchUserProfile(userId, _token!);
      currentUser = User.fromJson(responseData['user']);
      notifyListeners();
    } catch (error) {
      print("Profile loading error: $error");
      await logout(); // Clear local storage if fetching profile fails
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final responseData = await AuthApi.login(email, password);

      _token = responseData['token'];
      final userData = responseData['user']; // Ensure this matches the JSON structure
      currentUser = User.fromJson(userData);

      // Save token and user ID to secure storage
      await AuthApi.saveTokenAndUserId(_token!, currentUser!.id);
      notifyListeners();
    } catch (error) {
      print("Login error: $error");
      rethrow;
    }
  }

  Future<void> logout() async {
    _token = null;
    currentUser = null;
    await AuthApi.clearTokenAndUserId();
    notifyListeners();
  }

  Future<void> enterAsGuest() async {
    currentUser = null;
    notifyListeners();
  }

  bool isLoggedIn() => _token != null;
}
