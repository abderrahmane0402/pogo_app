
import 'package:flutter/material.dart';
import 'pages/FirstPage.dart';
import 'pages/second_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/profile': (context) => const Profile(),
        '/': (context) => const FirstPage(),
        '/beforeLogin': (context) => const SecondPage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        'infoPersonnels': (context) => const InfoPersonnel()
      },
    );
  }
}



