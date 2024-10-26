import 'package:flutter/material.dart';
import 'package:rehaish_app/api/dorm_api.dart';
import 'package:rehaish_app/models/dorm.dart';
import 'package:rehaish_app/config/enums.dart';

class DormProvider with ChangeNotifier {
  List<Dorm> _dorms = [];
  Dorm? _currentDorm;  // Holds the details of a single dorm
  DataStatus _dataStatus = DataStatus.initial;
  
  List<Dorm> get dorms => _dorms;
  Dorm? get currentDorm => _currentDorm;
  DataStatus get dataStatus => _dataStatus;

  // Fetch dorms
  Future<void> fetchDorms() async {
    if (_dataStatus == DataStatus.loaded) return;  // Prevent fetching again if already loaded

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

  // Fetch a single dorm by ID, avoiding multiple API calls
  Future<void> fetchDormById(String id) async {
    if (_currentDorm != null && _currentDorm!.id == id) return;  // If dorm is already fetched, don't fetch again

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
}
