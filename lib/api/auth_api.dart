// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../config/constants.dart';
// class AuthApi {
  
//   // Login API call
//   static Future<Map<String, dynamic>> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('${Constants.baseUrl}/users/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Login failed");
//     }
//   }

//   // Signup API call
//   static Future<Map<String, dynamic>> signup(Map<String, String> userData) async {
//     final response = await http.post(
//       Uri.parse('${Constants.baseUrl}/users/signup'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(userData),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Signup failed");
//     }
//   }
// }
