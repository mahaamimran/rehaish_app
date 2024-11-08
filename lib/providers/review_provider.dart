import 'package:flutter/material.dart';
import 'package:rehaish_app/api/review_api.dart';
import 'package:rehaish_app/models/review.dart';

class ReviewProvider with ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  Future<void> fetchReviews(String dormId) async {
    try {
      _reviews = await ReviewApi.getReviewsByDorm(dormId);
      notifyListeners();
    } catch (error) {
      print("Error fetching reviews: $error");
      throw Exception("Failed to fetch reviews");
    }
  }
}
