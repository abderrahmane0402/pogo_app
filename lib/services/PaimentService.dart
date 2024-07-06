import 'dart:convert';
import 'package:example_app/config/url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  final String _baseUrl = url + "paiment/"; // Remplacez par l'URL de votre API
  final String _histUrl = url + "paiment/historique/";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>?> makePayment({
    required double amount,
    required String recepteurId,
  }) async {
    final url = Uri.parse(_baseUrl);
    String? token = await storage.read(key: 'auth_token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
      'amount': amount,
      'user_id': recepteurId,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print(response.body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getHistorique() async {
    final url = Uri.parse(_histUrl);
    String? token = await storage.read(key: 'auth_token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
