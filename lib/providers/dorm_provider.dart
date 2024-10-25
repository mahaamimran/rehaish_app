import 'package:flutter/material.dart';
import '../api/dorm_api.dart';
import '../models/dorm.dart';

class DormProvider with ChangeNotifier {
  List<Dorm> _dorms = [];
  bool _isLoading = false;

  List<Dorm> get dorms => _dorms;
  bool get isLoading => _isLoading;

  // Fetch dorms from the API
  Future<void> fetchDorms() async {
    _isLoading = true;
    notifyListeners();

    try {
      _dorms = (await DormApi.getDorms()).map((data) => Dorm.fromJson(data)).toList();
    } catch (error) {
      print('Error fetching dorms: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
