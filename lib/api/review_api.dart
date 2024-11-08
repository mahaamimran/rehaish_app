import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rehaish_app/models/review.dart';
import '../config/constants.dart';

class ReviewApi {
  static Future<List<Review>> getReviewsByDorm(String dormId) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/dorms/$dormId'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      
      // Check if "reviews" is present in the response
      if (jsonResponse['reviews'] != null) {
        List<dynamic> reviewData = jsonResponse['reviews'];
        return reviewData.map((reviewJson) => Review.fromJson(reviewJson)).toList();
      } else {
        throw Exception("No reviews found for this dorm");
      }
    } else {
      throw Exception("Failed to load reviews for dorm");
    }
  }
}
