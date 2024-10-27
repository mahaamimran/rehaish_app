import 'package:flutter/material.dart';
import 'package:rehaish_app/api/dorm_api.dart';
import 'package:rehaish_app/models/dorm.dart';
import 'package:rehaish_app/config/enums.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

class DormProvider with ChangeNotifier {
  List<Dorm> _dorms = [];
  Dorm? _currentDorm;
  DataStatus _dataStatus = DataStatus.initial;

  List<Dorm> get dorms => _dorms;
  Dorm? get currentDorm => _currentDorm;
  DataStatus get dataStatus => _dataStatus;

  Future<void> fetchDorms() async {
    if (_dataStatus == DataStatus.loaded) return;

    _dataStatus = DataStatus.loading;
    notifyListeners();

    try {
      final dormsData = await DormApi.getDorms();
      _dorms = dormsData.map((data) => Dorm.fromJson(data)).toList();
      _dataStatus = DataStatus.loaded;
    } catch (error) {
      _dataStatus = DataStatus.failure;
      print('Error fetching dorms: $error');
    }
    notifyListeners();
  }

  Future<void> fetchDormById(String id) async {
    if (_currentDorm != null && _currentDorm!.id == id) return;

    _dataStatus = DataStatus.loading;
    notifyListeners();

    try {
      _currentDorm = await DormApi.getDormById(id);
      _dataStatus = DataStatus.loaded;
    } catch (error) {
      _dataStatus = DataStatus.failure;
      print('Error fetching dorm: $error');
    }
    notifyListeners();
  }

  List<Dorm> getDormsByIds(List<String> dormIds) {
    return _dorms.where((dorm) => dormIds.contains(dorm.id)).toList();
  }

  Future<void> toggleBookmark(String dormId, BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (!authProvider.isLoggedIn()) {
      Navigator.of(context).pushReplacementNamed('/login');
      return;
    }

    try {
      final isBookmarked = authProvider.currentUser!.bookmarks.contains(dormId);

      final updatedBookmarkState = await DormApi.toggleBookmark(
          dormId, authProvider.token!, isBookmarked);

      if (updatedBookmarkState) {
        authProvider.currentUser!.bookmarks.add(dormId);
        print('Bookmark added: $dormId');
      } else {
        authProvider.currentUser!.bookmarks.remove(dormId);
        print('Bookmark removed: $dormId');
      }

      notifyListeners();
    } catch (error) {
      print("Error bookmarking dorm: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update bookmark')),
      );
    }
  }
}
