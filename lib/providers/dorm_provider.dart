import 'package:flutter/material.dart';
import 'package:rehaish_app/config/enums.dart';
import 'package:rehaish_app/api/dorm_api.dart';
import 'package:rehaish_app/models/dorm.dart';

class DormProvider with ChangeNotifier {
  List<Dorm> _dorms = [];
  DataStatus _dataStatus = DataStatus.initial;
  bool _hasFetchedDorms = false;  // New flag to indicate if dorms are already fetched

  List<Dorm> get dorms => _dorms;
  DataStatus get dataStatus => _dataStatus;

  // Fetch dorms from the API
  Future<void> fetchDorms() async {
    if (_hasFetchedDorms) {
      return;  // Don't fetch again if dorms are already fetched
    }

    _dataStatus = DataStatus.loading;
    notifyListeners();

    try {
      final dormsData = await DormApi.getDorms();
      _dorms = dormsData.map((data) => Dorm.fromJson(data)).toList();
      _dataStatus = DataStatus.loaded;
      _hasFetchedDorms = true;  // Set flag to true when dorms are fetched
    } catch (error) {
      _dataStatus = DataStatus.failure;
      print('Error fetching dorms: $error');
    }

    notifyListeners();
  }
}
