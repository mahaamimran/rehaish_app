import 'amenity.dart';
import 'city.dart';
import 'user.dart';
import 'review.dart';

class Dorm {
  final String id;
  final String title;
  final String description;
  final User? owner;
  final double pricePerMonth;
  final City city;
  final List<Amenity> amenities;
  final int views;
  final double rating;
  final String imageCover;
  final List<String> images;
  final bool guestFavorite;
  final List<Review> reviews;

  Dorm({
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.pricePerMonth,
    required this.city,
    required this.amenities,
    required this.views,
    required this.rating,
    required this.imageCover,
    required this.images,
    required this.guestFavorite,
    required this.reviews,
  });

factory Dorm.fromJson(Map<String, dynamic> json) {
  return Dorm(
    id: json['_id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    owner: json['owner'] != null ? User.fromJson(json['owner']) : null,  // Handle null owner
    pricePerMonth: json['pricePerMonth'] != null ? json['pricePerMonth'].toDouble() : 0.0,
    city: City.fromJson(json['address']['city']),
    amenities: (json['amenities'] as List)
        .map((amenityJson) => Amenity.fromJson(amenityJson))
        .toList(),
    views: json['views'] ?? 0,
    rating: json['rating'] != null ? json['rating'].toDouble() : 0.0,
    imageCover: json['imageCover'] ?? '',


    images: List<String>.from(json['images'] ?? []),
    guestFavorite: json['guestFavorite'] ?? false,
    reviews: (json['reviews'] as List<dynamic>?)?.map((reviewJson) {
      if (reviewJson is String) {
        // If it's a string, assume it's a review ID and create a minimal Review object
        return Review(id: reviewJson, rating: 0, title: '', text: '', user: User(id: '', username: '', email: '', firstName: '', lastName: '', profilePicture: '', bookmarks: []));
      } else if (reviewJson is Map<String, dynamic>) {
        // If it's a map, parse it as a full Review object
        return Review.fromJson(reviewJson);
      } else {
        // If it's neither, return null (invalid review data)
        return null;
      }
    }).whereType<Review>().toList() ?? [],
  );
}


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'owner': owner?.toJson(),
      'pricePerMonth': pricePerMonth,
      'address': {'city': city.toJson()},
      'amenities': amenities.map((a) => a.toJson()).toList(),
      'views': views,
      'rating': rating,
      'imageCover': imageCover,
      'images': images,
      'guestFavorite': guestFavorite,
      'reviews': reviews.map((r) => r.toJson()).toList(),
    };
  }
}
