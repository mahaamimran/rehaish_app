import 'user.dart';

class Review {
  final String id;
  final String title;
  final String text;
  final double rating;
  final User user;

  Review({
    required this.id,
    required this.title,
    required this.text,
    required this.rating,
    required this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      title: json['title'],
      text: json['text'],
      rating: json['rating'].toDouble(),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'text': text,
      'rating': rating,
      'user': user.toJson(),
    };
  }
}
