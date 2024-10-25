import 'amenity.dart';
import 'city.dart';
import 'user.dart';
import 'review.dart';

class Dorm {
  final String id;
  final String title;
  final String description;
  final User owner;
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
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      owner: User.fromJson(json['owner']),
      pricePerMonth: json['pricePerMonth'].toDouble(),
      city: City.fromJson(json['address']['city']),
      amenities: (json['amenities'] as List)
          .map((amenityJson) => Amenity.fromJson(amenityJson))
          .toList(),
      views: json['views'],
      rating: json['rating'].toDouble(),
      imageCover: json['imageCover'],
      images: List<String>.from(json['images']),
      guestFavorite: json['guestFavorite'],
      reviews: (json['reviews'] as List)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'owner': owner.toJson(),
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
