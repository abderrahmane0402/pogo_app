// Importing necessary libraries
import 'package:example_app/pages/AddCarte.dart';
import 'package:example_app/pages/CarteBancaire.dart';
import 'package:example_app/pages/home.dart';
import 'package:example_app/pages/info_personnel.dart';
import 'package:example_app/pages/login_page.dart';
import 'package:example_app/pages/paiement.dart';
import 'package:example_app/pages/profile_page.dart';
import 'package:example_app/pages/qr_code.dart';
import 'package:example_app/pages/scan_qr_code.dart';
import 'package:flutter/material.dart';

// Define the main function, which is the entry point of the Dart application
void main() {
  // Call the runApp function to start the Flutter application
  runApp(const Layout());
}

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  // Define your pages here
  final List<Widget> _pages = [
    Home(),
    const Profile()
  ];

  // Function to handle item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/infoPersonnels': (context) => const InfoPersonnel(),
        "/beforeLogin": (context) => const Login(),
        "/carteBancaire": (context) => const CarteBancaire(),
        "/addCarte": (context) => const AddCarteBancaire(),
      },
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/pogo.png', width: 120, height: 60),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                      },
                      color: const Color.fromRGBO(5, 12, 79, 1.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Profile()),
                        );
                      },
                      color: const Color.fromRGBO(5, 12, 79, 1.0),
                    ),
                  ],
                ),
              ],
          ),
        ),
        // body: Center(child: _pages.elementAt(_selectedIndex)),

      ),
    );
  }
}
