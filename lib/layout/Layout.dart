// Importing necessary libraries
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
    const Home(),
    const Paiement(),
    const QR_Code(),
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
        "/scanQrCode": (context) => const ScanQrCode()
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
                  ],
                ),
              ],
          ),
        ),
        body: Center(child: _pages.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromRGBO(5, 12, 79, 1.0),
          unselectedLabelStyle:
              const TextStyle(color: Color.fromRGBO(5, 12, 79, 1.0)),
          backgroundColor: const Color.fromRGBO(
              44, 176, 145, 1.0), // Background color of the BottomNavigationBar
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'HOME',
              backgroundColor: Color.fromRGBO(63, 207, 173, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.payments_outlined,
              ),
              label: 'Paiement',
              backgroundColor: Color.fromRGBO(63, 207, 173, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_2,
              ),
              label: 'QR code',
              backgroundColor: Color.fromRGBO(63, 207, 173, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
              backgroundColor: Color.fromRGBO(63, 207, 173, 1),
            ),
          ],
          iconSize: 30,
          selectedIconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
    );
  }
}
