import 'package:example_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:example_app/pages/paiement.dart';
import 'package:example_app/pages/qr_code.dart';

import 'AddCarte.dart';
import 'CarteBancaire.dart';
import 'info_personnel.dart';
import 'login_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
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
    body:Column(
      children: [
        Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 3.0, right: 3.0,bottom: 10), // Adjust the value as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the top of the column
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(5, 12, 79, 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                alignment: Alignment.topCenter, // Align the child to the top
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.0), // Add padding to the top
                          child: SizedBox(
                            width: 140,
                            child: Text(
                              'Votre sécurité est notre priorité.',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 140, // Set your desired width here
                            child: Divider(
                              height: 20, // Set your desired height for the line
                              thickness: 2, // Set your desired thickness for the line
                              color: Colors.white, // Set your desired color for the line
                            ),
                          ),),
                        Padding(
                          padding:  EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: 140, // Set your desired width here
                            child: Text(
                              'Profitez de transactions sûres avec notre application mobile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Image.asset('assets/images/home.png',width: 140,),
                    ),



                  ],
                ),
              ),
            ),
            // Add more widgets here if needed
          ],
        ),
      ),
        const SizedBox(width: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const QR_Code()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  foregroundColor: const Color.fromRGBO(44, 176, 145, 1.0),
                  backgroundColor: const Color.fromRGBO(44, 176, 145, 1.0),
                  elevation: 0, // Remove elevation
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: Colors.transparent, // Border color
                      width: 2, // Border width
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.qr_code_2, size: 25, color: Colors.white),
                    Text('QR code', style: TextStyle(fontSize: 11, color: Colors.white)),
                    ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
                  // width: double.infinity, // Adjust width as needed
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Paiement()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      foregroundColor: const Color.fromRGBO(44, 176, 145, 1.0),
                      backgroundColor: Colors.white, // Text color
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(
                          color: const Color.fromRGBO(44, 176, 145, 1.0), // Border color
                          width: 2, // Border width
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payments_outlined, size: 25, color: const Color.fromRGBO(44, 176, 145, 1.0)),
                        Text('Paiement', style: TextStyle(fontSize: 11, color: const Color.fromRGBO(44, 176, 145, 1.0))),
                      ],
                    ),
                  ),
                ),

          ],
        )
      ]
    )));
  }
}

void main() {
  runApp(const MaterialApp(home: Home()));
}

// SizedBox(
// // Remove explicit height from SizedBox
// child: Column(
// mainAxisSize: MainAxisSize.min,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Container(
// // Height will be determined by its content
// decoration: BoxDecoration(
// color: const Color.fromRGBO(180, 230, 233, 1.0),
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Padding(
// padding: const EdgeInsets.all(12.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Voulez-vous effectuer un paiement ?',
// style: TextStyle(fontSize: 20),
// softWrap: true,
// overflow: TextOverflow.visible,
// ),
// SizedBox(
// height: 40, // Set height for the button
// child: SizedBox(
// height: 40, // Adjust the height here
// child:Align(
// alignment: Alignment.bottomRight,
// child: ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => const QR_Code()),
// );
// },
// style: ElevatedButton.styleFrom(
// padding: EdgeInsets.zero,
// backgroundColor: const Color.fromRGBO(5, 12, 79, 1.0),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// elevation: 0,
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// mainAxisSize: MainAxisSize.min, // Set the row to take minimum space
// children: [
// Icon(Icons.payments_outlined, size: 20, color: Colors.white),
// SizedBox(width: 5), // Add spacing between icon and text
// Text('Paiement', style: TextStyle(fontSize: 11, color: Colors.white)),
// ],
// ),
// ),
// ),
// )
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// );


// SizedBox(
// height: 70,
// width: double.infinity,
// child: Container(
// decoration: BoxDecoration(
// color: const Color.fromRGBO(5, 12, 79, 1.0),
// borderRadius: BorderRadius.circular(10.0),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => const Paiement()),
// );
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.transparent, // Set transparent color
// elevation: 0, // Remove elevation
// shadowColor: Colors.transparent, // Set shadow color to transparent
// ),
// child: const Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Icon(Icons.payments_outlined, size: 30, color: Colors.white),
// SizedBox(height: 5), // Adjust as needed
// Text('Paiement', style: TextStyle(fontSize: 11, color: Colors.white)),
// ],
// ),
// ),
//
// ElevatedButton(
// onPressed: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => const QR_Code()),
// );
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.transparent, // Set transparent color
// elevation: 0, // Remove elevation
// shadowColor: Colors.transparent, // Set shadow color to transparent
// ),
// child: const Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Icon(Icons.qr_code_2, size: 30, color: Colors.white,),
// SizedBox(height: 5), // Adjust as needed
// Text('QR code', style: TextStyle(fontSize: 11, color: Colors.white)),
// ],
// ),
// ),
// ],
// ),
// ),
// ),

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
