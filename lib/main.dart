import 'package:example_app/pages/AddCarte.dart';
import 'package:example_app/pages/CarteBancaire.dart';
import 'package:example_app/pages/Verifier_phone.dart';
import 'package:example_app/pages/home.dart';
import 'package:example_app/pages/info_personnel.dart';
import 'package:example_app/pages/register1_page.dart';
import 'package:example_app/services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/FirstPage.dart';
import 'pages/second_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() {
  AuthService authService = AuthService();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.lifecycle.setMessageHandler((msg) {
    if (msg == AppLifecycleState.paused.toString()) {
      // authService.logout();
    }
    return Future.value(null);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),

      routes: {
        '/Home': (context) => Home(),
        '/': (context) => const FirstPage(),
        '/beforeLogin': (context) => const SecondPage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/phone_number' :(context) => const PhoneForm(),
        '/verifier_phone': (context) => const VerifierPhone(),
        '/infoPersonnels': (context) => const InfoPersonnel(),
        '/carteBancaire':(context) => const CarteBancaire(),
        '/addCarte':(context) => const AddCarteBancaire()
      },
    );
  }
}
