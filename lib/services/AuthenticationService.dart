import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:example_app/config/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<http.Response> register(String nom, String prenom, String telephone, String password, String confirmePassword) async {
    try {
      var regBody = {
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'password': password,
        'confirmePassword': confirmePassword
      };

      var response = await http.post(
        Uri.parse(register_url),  // Replace with your actual URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response;
    } catch (e) {
      print('Error: $e');
      throw e;  // Re-throwing the error to be handled in the calling function
    }
  }





  Future<http.Response?> login(String tel, String password) async {
    try {
      var regBody = {
        "login": tel,
        "password": password,
      };
      final response = await http.post(
        Uri.parse(login_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        String token = responseBody['data']['token'];
        var user = responseBody['data']['user'];

        await storage.write(key: 'auth_token', value: token);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_nom', user['nom']);
        await prefs.setString('user_prenom', user['prenom']);
        await prefs.setString('user_telephone', user['telephone'].toString());
        await prefs.setString('user_password', user['password']);
        await prefs.setString('user_id', user['_id']);

        return response;
      } else if (response.statusCode == 400) {
        var responseBody = jsonDecode(response.body);
        print('Error: ${responseBody['message']}');
        return response;
      } else {
        print('Unexpected status code: ${response.statusCode}');
        return response;
      }
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }


  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_nom');
    await prefs.remove('user_prenom');
    await prefs.remove('user_telephone');
    await prefs.remove('user_password');

    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'card');
    print('logged out!');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }
}

