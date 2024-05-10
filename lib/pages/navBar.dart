// import 'package:example_app/pages/home.dart';
// import 'package:example_app/pages/paiement.dart';
// import 'package:example_app/pages/profile_page.dart';
// import 'package:example_app/pages/qr_code.dart';
// import 'package:flutter/material.dart';

// class ButtonNavigationBar extends StatefulWidget {
//   const ButtonNavigationBar({super.key});

//   @override
//   State<ButtonNavigationBar> createState() => _ButtonNavigationBarState();
// }

// class _ButtonNavigationBarState extends State<ButtonNavigationBar> {
//   int _selectedIndex = 0;

//   // Define your pages here
//   final List<Widget> _pages = [
//     const Home(),
//     const Paiement(),
//     const QR_Code(),
//     const Profile()
//   ];

//   // Function to handle item selection
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return {
//       BottomNavigationBar(
//         selectedItemColor: Colors.white,
//         unselectedItemColor: const Color.fromRGBO(5, 12, 79, 1.0),
//         unselectedLabelStyle:
//             const TextStyle(color: Color.fromRGBO(5, 12, 79, 1.0)),
//         backgroundColor: const Color.fromRGBO(
//             44, 176, 145, 1.0), // Background color of the BottomNavigationBar
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             label: 'HOME',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.money_outlined,
//             ),
//             label: 'Paiement',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.qr_code_2,
//             ),
//             label: 'QR code',
//           ),
//         ],

//         iconSize: 30,
//         selectedIconTheme: const IconThemeData(color: Colors.white),
//       )
//     };
//   }
// }
