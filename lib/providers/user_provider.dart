import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api/user_api.dart';
import '../config/constants.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  User? currentUser;

  // Method to add bookmark
  Future<void> addBookmark(String dormId) async {
    final token = await UserApi.getToken(); // Retrieve the token
    print("Token: $token");
    try {
      final response = await http.patch(
        Uri.parse('${Constants.baseUrl}/users/bookmark'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({"dormId": dormId}),
      );

      print("Add Bookmark Response Status: ${response.statusCode}");
      print("Add Bookmark Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Update local state if bookmark addition is successful
        // e.g., update your user's bookmarks list
        notifyListeners();
      } else {
        throw Exception('Failed to add bookmark');
      }
    } catch (error) {
      print("Error adding bookmark: $error");
      rethrow;
    }
  }

  // Method to remove bookmark
  Future<void> removeBookmark(String dormId) async {
    try {
      final token = await storage.read(key: 'jwtToken');
      final response = await http.patch(
        Uri.parse('${Constants.baseUrl}/users/unbookmark'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({"dormId": dormId}),
      );

      if (response.statusCode == 200) {
        currentUser?.bookmarks.remove(dormId);
        notifyListeners(); // Notify UI of changes
      } else {
        throw Exception('Failed to remove bookmark');
      }
    } catch (error) {
      print("Error removing bookmark: $error");
      rethrow;
    }
  }

  bool isBookmarked(String dormId) {
    return currentUser?.bookmarks.contains(dormId) ?? false;
  }
}
