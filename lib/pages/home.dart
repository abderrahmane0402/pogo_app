import 'package:flutter/material.dart';
import 'package:example_app/pages/paiement.dart';
import 'package:example_app/pages/qr_code.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(5, 12, 79, 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Paiement()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Set transparent color
                      elevation: 0, // Remove elevation
                      shadowColor: Colors.transparent, // Set shadow color to transparent
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payments_outlined, size: 30, color: Colors.white),
                        SizedBox(height: 5), // Adjust as needed
                        Text('Paiement', style: TextStyle(fontSize: 11, color: Colors.white)),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QR_Code()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Set transparent color
                      elevation: 0, // Remove elevation
                      shadowColor: Colors.transparent, // Set shadow color to transparent
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.qr_code_2, size: 30, color: Colors.white,),
                        SizedBox(height: 5), // Adjust as needed
                        Text('QR code', style: TextStyle(fontSize: 11, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: Home()));
}

// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// NavigationRail(
// selectedIndex: _selectedIndex,
// onDestinationSelected: (int index) {
// setState(() {
// _selectedIndex = index;
// });
// },
// destinations: const [
//
// NavigationRailDestination(
// icon: Icon(Icons.payments_outlined),
// label: Text('Paiement'),
// ),
// NavigationRailDestination(
// icon: Icon(Icons.qr_code_2),
// label: Text('QR code'),
// ),
// ],
// ),
// ],
// ),
// Expanded(
// child: _widgetOptions[_selectedIndex],
// ),
// ],
// ),
