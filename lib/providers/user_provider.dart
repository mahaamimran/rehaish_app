import 'package:flutter/material.dart';
import '../api/user_api.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? currentUser;

  // Method to add bookmark using UserApi
  Future<void> addBookmark(String dormId) async {
    try {
      await UserApi.addBookmark(dormId);
      currentUser?.bookmarks.add(dormId); // Update local state
     print("Bookmark added");
      notifyListeners();
    } catch (error) {
      print("Error adding bookmark: $error");
      rethrow;
    }
  }

  // Method to remove bookmark using UserApi
  Future<void> removeBookmark(String dormId) async {
    try {
      await UserApi.removeBookmark(dormId);
      currentUser?.bookmarks.remove(dormId); // Update local state
      notifyListeners();
    } catch (error) {
      print("Error removing bookmark: $error");
      rethrow;
    }
  }

  bool isBookmarked(String dormId) {
    return currentUser?.bookmarks.contains(dormId) ?? false;
  }
}
