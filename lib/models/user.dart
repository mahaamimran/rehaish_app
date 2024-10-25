class User {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String profilePicture;
  final List<String> bookmarks;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.bookmarks,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'] ?? 'default.jpg',
      bookmarks: List<String>.from(json['bookmarks'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
      'bookmarks': bookmarks,
    };
  }
}
