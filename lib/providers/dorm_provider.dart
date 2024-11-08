import 'package:flutter/material.dart';
import 'package:rehaish_app/api/dorm_api.dart';
import 'package:rehaish_app/models/dorm.dart';
import 'package:rehaish_app/config/enums.dart';

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
  Future<void> addReviewToDorm(Dorm dorm, String title, String text, double rating, String userId) async {
      try {
        final newReview = await DormApi.addReview(dorm.id, title, text, rating, userId);
        dorm.reviews.add(newReview); // Add the new review to the current dorm's reviews
        notifyListeners(); // Update UI
      } catch (error) {
        print("Error adding review: $error");
      }
    }
 
}
