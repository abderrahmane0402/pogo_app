import 'dart:convert';
import 'package:example_app/config/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class CarteService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();


  Future<void> addCard(String nomProprietaire, String numCarte, String cvv, String dateExperation, bool isdefault) async {
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


  Future<Map<String, dynamic>?> getAllCards(String authToken) async {
    try {
      final response = await http.post(
        Uri.parse(all_carts),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      // Log status code and response body for debugging
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Check if response.body is not null before returning it
      // Check if the response is successful
      if (response.statusCode == 201) {
        Map<String, dynamic> responseData = {
          'statusCode': response.statusCode,
          'body': response.body,
        };
        return responseData;
      } else {
        print('Failed to fetch cards: ${response.statusCode}');
        return null;
      }
        } catch (e) {
      print('Error fetching cards: $e');
      return null;
    }
  }


  Future<void> changeDefaultCarte(String id, String carteID, String authToken) async {
    try {
      final response = await http.post(
        Uri.parse('$changeDefault/$carteID'),  // Include carteID in the URL
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(<String, String>{
          'id': id,
        }),
      );

      print('Request sent to: $changeDefault/$carteID');
      print('Headers: ${{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      }}');
      print('Body: ${jsonEncode(<String, String>{
        'id': id,
      })}');

      if (id == null) {
        print('id null');
      } else if (carteID == null) {
        print('carteID is null');
      } else if (authToken == null) {
        print('authToken is null');
      } else {
        print('All parameters are there');
      }

      if (response.statusCode == 201) {
        print('Carte modifiée avec succès');
      } else if (response.statusCode == 404) {
        print('404 error');
        try {
          var responseBody = jsonDecode(response.body);
          print('Error message: ${responseBody['message']}');
        } catch (e) {
          print('Error decoding response body: $e');
          print('Response body: ${response.body}');
        }
      } else {
        print('Erreur lors de la modification de la carte: ${response.reasonPhrase}');
        try {
          var responseBody = jsonDecode(response.body);
          print('Response body: $responseBody');
        } catch (e) {
          print('Error decoding response body: $e');
          print('Response body: ${response.body}');
        }
      }
    } catch (error) {
      print('Erreur lors de la modification de la carte: $error');
    }
  }


  Future<void> deleteCard(String cardId, String authToken) async {
    final String apiUrl = '$delete_card/$cardId';

    try {
      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Card successfully deleted
        print(responseData['message']);
        // Perform any UI updates as needed
      } else {
        // Handle error response
        print('Error: ${responseData['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserCarte(String userId, String carteId) async {
    // Define your API endpoint URL
     String apiUrl = getUserCarte_;
     String? authToken = await storage.read(key: 'auth_token');


     final Map<String, dynamic> requestBody = {
       'id_user': userId,
       'id_carte': carteId,
     };

     try {
       final http.Response response = await http.post(
         Uri.parse(apiUrl),
         body: jsonEncode(requestBody),
         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
           'Authorization': 'Bearer $authToken',
         },
       );

       if (response.statusCode == 200) {
         // If the response is successful, decode the JSON and return it
         final Map<String, dynamic> responseBody = jsonDecode(response.body);
         // print(responseBody);
         return responseBody;
       } else {
         // If the response status code is not 200, decode the JSON to extract error message
         final dynamic errorJson = jsonDecode(response.body);
         print(response.body);
         throw Exception('Failed to get user carte: ${errorJson['message']}');
       }
     } catch (e) {
       // If an exception occurs during the HTTP request,
       // print the error and return null to indicate failure
       print('Failed to get user carte: $e');
       return null;
     }
  }
}



