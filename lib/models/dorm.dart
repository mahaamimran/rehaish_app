import 'amenity.dart';
import 'user.dart';
import 'review.dart';
import 'address.dart'; // Import the new Address model

class Dorm {
  final String id;
  final String title;
  final String description;
  final User? owner;
  final double pricePerMonth;
  final Address address;  // Use Address instead of City directly
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
    required this.address,  // Updated to use Address model
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
      address: Address.fromJson(json['address']),  // Updated to use Address model
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
          return Review(id: reviewJson, rating: 0, title: '', text: '', user: User(id: '', username: '', email: '', firstName: '', lastName: '', profilePicture: '', bookmarks: []));
        } else if (reviewJson is Map<String, dynamic>) {
          return Review.fromJson(reviewJson);
        } else {
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
      'address': address.toJson(),  // Updated to include Address model
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
