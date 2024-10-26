
import 'package:rehaish_app/models/city.dart';

class Address {
  final City city;
  final String street;
  final String province;
  final String country;

  Address({
    required this.city,
    required this.street,
    required this.province,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: City.fromJson(json['city']),
      street: json['street'] ?? '',
      province: json['province'] ?? '',
      country: json['country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city.toJson(),
      'street': street,
      'province': province,
      'country': country,
    };
  }
}
