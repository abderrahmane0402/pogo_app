import 'dart:convert';

import 'package:example_app/pages/paiement.dart';
import 'package:example_app/pages/profile_page.dart';
import 'package:example_app/pages/qr_code.dart';
import 'package:example_app/pages/scan_qr_code.dart';
import 'package:example_app/services/CartService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'AddCarte.dart';
import 'CarteBancaire.dart';
import 'info_personnel.dart';
import 'login_page.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  bool dataCard = false;

  final storage = const FlutterSecureStorage();
  CarteService carteService = CarteService();

  @override
  void initState() {
    super.initState();
    fetchAndStoreDefaultCard();
  }

  Future<void> fetchAndStoreDefaultCard() async {
    try {
      String? authToken = await storage.read(key: 'auth_token');
      var defaultCardResponse = await carteService.getDefaultCard(authToken!);

      if (defaultCardResponse != null) {
        if (defaultCardResponse['statusCode'] == 201) {
          var defaultCardData = jsonDecode(defaultCardResponse['body']);
          var defaultCard = defaultCardData['carte'];
          await storage.write(key: 'card', value: jsonEncode(defaultCard));
          String? cardData = await storage.read(key: 'card');
          if (cardData != null) {
            Map<String, dynamic> defaultCard = jsonDecode(cardData);
            String numCarte = '${defaultCard['numCarte']}'.replaceAllMapped(
                RegExp(r".{4}"), (match) => "${match.group(0)} ");
            String ccvNum = defaultCard["cvv"].toString();
            String dateExperation = DateFormat('MM/yy')
                .format(DateTime.parse(defaultCard['dateExperation']));

            if (mounted) {
              // Check if the widget is still mounted
              setState(() {
                cardNumber = numCarte;
                cardHolderName = defaultCard['nomProprietaire'];
                expiryDate = dateExperation;
                cvvCode = ccvNum;
                dataCard = true;
              });
            }
            print('Stored Default Card Number: $cardNumber');
            print('Stored Expiry Date: $expiryDate');
          } else {
            if (mounted) {
              // Check if the widget is still mounted
              setState(() {
                dataCard = false;
              });
            }
            print('No default card data stored.');
          }
        } else {
          print(
              'Failed to fetch default card: ${defaultCardResponse['statusCode']}');
        }
      } else {
        print('Failed to fetch default card: null');
        if (mounted) {
          // Check if the widget is still mounted
          setState(() {
            dataCard = false;
          });
        }
      }

      // Get stored card data
    } catch (e) {
      print('Error fetching default card: $e');
      if (mounted) { // Check if the widget is still mounted
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Une erreur s\'est produite lors de la récupération de la carte par défaut: $e')),
        // );
      }
    }
  }

  Future<void> _refresh() async {
    // Call fetchUserCards to reload data
    await fetchAndStoreDefaultCard();
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
                    onPressed: () {},
                    color: const Color.fromRGBO(5, 12, 79, 1.0),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      ).then((value) => setState(() {
                            _refresh();
                          }));
                    },
                    color: const Color.fromRGBO(5, 12, 79, 1.0),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                dataCard
                    ? CreditCardWidget(
                        padding: 10,
                        height: 200,
                        cardBgColor: const Color.fromRGBO(30, 157, 151, 1.0),
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView: isCvvFocused,
                        obscureCardNumber: true,
                        bankName: '        ',
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        isSwipeGestureEnabled: false,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {
                          // Handle card brand change if needed
                        },
                        customCardTypeIcons: <CustomCardTypeIcon>[
                          CustomCardTypeIcon(
                            cardType: CardType.mastercard,
                            cardImage: Image.asset(
                              'assets/images/mastercard.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                          CustomCardTypeIcon(
                            cardType: CardType.visa,
                            cardImage: Image.asset(
                              'assets/images/visa.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/addCarte')
                                .then((value) async => await _refresh());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(30, 157, 151, 1.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Ajouter une default carte',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                const SizedBox(width: 40),
                Padding(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0, bottom: 10),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(19, 12, 79, 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const QRScanner()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.payments_outlined,
                                    size: 25, color: Colors.white),
                                SizedBox(height: 5),
                                Text('Paiement',
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const QR_Code()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.qr_code_2,
                                    size: 25, color: Colors.white),
                                SizedBox(height: 5),
                                Text('QR code',
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.history,
                                    size: 25, color: Colors.white),
                                SizedBox(height: 5),
                                Text('Historique',
                                    style: TextStyle(
                                        fontSize: 9, color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}