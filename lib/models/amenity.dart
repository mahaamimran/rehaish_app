class Amenity {
  final String id;
  final String name;
  final String? description;

  Amenity({
    required this.id,
    required this.name,
    this.description,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
    };
  }
}
