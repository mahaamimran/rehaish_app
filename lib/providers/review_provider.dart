import 'package:flutter/material.dart';
import 'package:rehaish_app/api/review_api.dart';
import 'package:rehaish_app/models/review.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';

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

  Future<void> addReview(String dormId, String title, String text, double rating, String userId, BuildContext context) async {
    try {
      // Get the authorization token from AuthProvider
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      if (token == null) throw Exception("User is not authenticated");

      // Call the addReview method with the token
      final newReview = await ReviewApi.addReview(dormId, title, text, rating, userId, token);
      _reviews.add(newReview);
      notifyListeners();
    } catch (error) {
      print("Error adding review: $error");
      throw Exception("Failed to add review");
    }
  }
}
