import 'package:flutter/material.dart';
import '../api/user_api.dart';

class UserProvider extends ChangeNotifier {
  List<String> _bookmarkedDormIds = [];

  List<String> get bookmarkedDormIds => _bookmarkedDormIds;

  UserProvider() {
    _fetchBookmarks();
  }

  Future<void> _fetchBookmarks() async {
    try {
      final bookmarks = await UserApi.getBookmarks();
      _bookmarkedDormIds = bookmarks.map((dorm) => dorm['_id'] as String).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching bookmarks: $error");
    }
  }

  Future<void> addBookmark(String dormId) async {
    try {
      await UserApi.addBookmark(dormId);
      _bookmarkedDormIds.add(dormId);
      notifyListeners();
    } catch (error) {
      print("Error adding bookmark: $error");
    }
  }

  Future<void> removeBookmark(String dormId) async {
    try {
      await UserApi.removeBookmark(dormId);
      _bookmarkedDormIds.remove(dormId);
      notifyListeners();
    } catch (error) {
      print("Error removing bookmark: $error");
    }
  }

  bool isBookmarked(String dormId) {
    return _bookmarkedDormIds.contains(dormId);
  }
}
