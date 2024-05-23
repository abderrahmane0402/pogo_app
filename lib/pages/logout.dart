import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart'; // if you use SharedPreferences

class AuthService {

  static Future<void> logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    // Clear user data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_nom');
    await prefs.remove('user_prenom');
    await prefs.remove('user_telephone');
    await prefs.remove('user_password');

    await storage.delete(key: 'auth_token');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
