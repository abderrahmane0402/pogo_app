// auth_provider.dart
import 'package:flutter/material.dart';

import 'package:example_app/services/AuthenticationService.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  AuthProvider({required this.authService});

  Future<void> login(String email, String password) async {
    final user = await authService.login(email, password);
    if (user != null) {
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final token = await authService.getToken();
    _isAuthenticated = token != null;
    notifyListeners();
  }
}
