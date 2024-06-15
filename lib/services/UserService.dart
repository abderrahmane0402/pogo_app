import 'dart:convert';
import 'package:example_app/config/url.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> updateUser({
    required String nom,
    required String prenom,
    required String telephone,
  }) async {
    try {
      String? token = await storage.read(key: 'auth_token');
      final response = await http.put(
        Uri.parse(updateUser_), // Use Uri.parse() with the correct URL variable
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include the token in the Authorization header
        },
        body: jsonEncode({
          'nom': nom,
          'prenom': prenom,
          'telephone': telephone,
        }),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          print('User updated successfully');
        } else {
          print('Failed to update user: ${responseData['message']}');
        }
      } else {
        final responseData = jsonDecode(response.body);
        print('Server error: ${response.statusCode}, Message: ${responseData['message']}');
      }
    } catch (error) {
      print('Error updating user data: $error');
    }
  }


  Future<void> updatePassword( {required String oldPassword, required String newPassword,}) async {
    final url = Uri.parse(updatePassword_); // Replace with your API URL
    String? token = await storage.read(key: 'auth_token');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add the authorization token
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print(responseBody['message']); // Handle success response
      } else {
        final responseBody = jsonDecode(response.body);
        print(responseBody['message']); // Handle error response
      }
    } catch (error) {
      print('Error: $error'); // Handle any other errors
    }
  }





}
