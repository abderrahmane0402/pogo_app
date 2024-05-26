import 'dart:convert';
import 'package:example_app/config/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class CarteService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();


  Future<void> addCard(String nomProprietaire, String numCarte, int cvv, String dateExperation, bool isdefault) async {
    try {
      // Retrieve the auth token from secure storage
      String? token = await storage.read(key: 'auth_token');

      // Remove spaces from card number
      String formattedNumCarte = numCarte.replaceAll(' ', '');

      // Parse and format the expiration date string to a full date
      DateTime expirationDate = DateFormat('MM/yy').parse(dateExperation);
      // Set the day to the first of the month
      expirationDate = DateTime(expirationDate.year, expirationDate.month, 1);

      var regBody = {
        'nomProprietaire': nomProprietaire,
        'numCarte': formattedNumCarte,
        'cvv': cvv,
        'dateExperation': expirationDate.toIso8601String(), // Format to ISO 8601 string
        'isdefault': isdefault.toString(),
      };

      var response = await http.post(
        Uri.parse(add_cart), // Replace with your actual API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include the token in the Authorization header
        },
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 201) {
        // Handle success
        print('Card added successfully');
      } else {
        // Handle other status codes
        print('Failed to add card: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle errors
      print('An error occurred: $e');
    }
  }
  Future<Map<String, dynamic>?> getDefaultCard(String authToken) async {
    final String url = default_cart;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = {
          'statusCode': response.statusCode,
          'body': response.body,
        };
        return responseData;
      } else {
        print('Failed to fetch default card: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching default card: $e');
      return null;
    }
  }



}
