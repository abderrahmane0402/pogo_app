import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:example_app/services/CartService.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class CarteBancaireModel {
  final int cardNumber;
  final String expirationDate;
  final String cvv;
  final String cartHolder;
  final bool isdefault;
  final String cardId;

  CarteBancaireModel(
      {required this.cardNumber,
      required this.expirationDate,
      required this.cartHolder,
      required this.cvv,
      required this.isdefault,
      required this.cardId});

  factory CarteBancaireModel.fromJson(Map<String, dynamic> json) {
    String formattedExpirationDate =
        DateFormat('MM/yy').format(DateTime.parse(json['dateExperation']));
    return CarteBancaireModel(
        cardNumber: json['numCarte'],
        expirationDate: formattedExpirationDate,
        cartHolder: json['nomProprietaire'],
        cvv: json['cvv'] ?? 0,
        isdefault: json['isdefault'],
        cardId: json['_id'] // Provide a default value if cvv is null
        );
  }
}

class CarteBancaire extends StatefulWidget {
  const CarteBancaire({super.key});

  @override
  State<CarteBancaire> createState() => _CarteBancaireState();
}

class _CarteBancaireState extends State<CarteBancaire> {
  CarteService cartService = CarteService();
  final storage = const FlutterSecureStorage();
  // SharedPreferences prefs =  SharedPreferences.getInstance();

  List<CarteBancaireModel> cartesBancaires = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserCards();
  }

  Future<void> fetchUserCards() async {
    try {
      String? authToken = await storage.read(key: 'auth_token');
      if (authToken != null) {
        final response = await cartService.getAllCards(authToken);
        if (response != null) {
          int? statusCode = response['statusCode'];
          if (statusCode != null && statusCode == 201) {
            // Check if response['body'] is not null before decoding
            if (response['body'] != null) {
              Map<String, dynamic> responseBody = json.decode(response['body']);
              // print(responseBody);
              List<dynamic> cartesJson = responseBody['cartes'];
              print(cartesJson);
              setState(() {
                cartesBancaires = cartesJson
                    .map((json) => CarteBancaireModel.fromJson(
                        json as Map<String, dynamic>))
                    .toList();
                isLoading = false;
              });
            } else {
              // Handle the case where response['body'] is null
              print('Response body is null');
              throw Exception('Failed to load cards');
            }
          } else {
            print('Unexpected status code: $statusCode');
            throw Exception('Failed to load cards');
          }
        } else {
          // Handle the case where response is null
          print('Response is null');
          throw Exception('Failed to load cards');
        }
      } else {
        print('Auth token is null');
        throw Exception('Failed to load cards: Auth token is null');
      }
    } catch (e) {
      print('Error fetching cards: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching cards: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteCarte(String idCarte) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = await storage.read(key: 'auth_token');
      await cartService.deleteCard(idCarte, authToken!);
      _refresh();
    } catch (e) {
      print('Error deleting card: $e');
    }
  }

  Future<void> changeDefault(String carteId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = await storage.read(key: 'auth_token');
      String? userId = prefs.getString('user_id');

      final response =
          await cartService.changeDefaultCarte(userId!, carteId, authToken!);
    } catch (e) {
      print('Error changing default card: $e');
    }
  }

  Future<void> _refresh() async {
    // Call fetchUserCards to reload data
    await fetchUserCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Vos Cartes bancaires",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500, // Texte en vert d'eau
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cartesBancaires.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    CreditCardWidget(
                                      padding: 10,
                                      height: 170,
                                      cardBgColor: const Color.fromRGBO(
                                          30, 157, 151, 1.0),
                                      cardNumber: cartesBancaires[index]
                                          .cardNumber
                                          .toString(),
                                      expiryDate:
                                          cartesBancaires[index].expirationDate,
                                      cardHolderName:
                                          cartesBancaires[index].cartHolder,
                                      cvvCode:
                                          cartesBancaires[index].cvv.toString(),
                                      obscureCardNumber: true,
                                      obscureCardCvv: true,
                                      isChipVisible: false,
                                      bankName: "        ",
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
                                      showBackView: false,
                                    ),
                                    if (cartesBancaires[index].isdefault)
                                      Positioned(
                                        top: 1,
                                        left: 10,
                                        child: Icon(
                                          Icons.bookmark,
                                          color: Color.fromRGBO(5, 12, 75, 1.0),
                                          size: 40, // Adjust the size as needed
                                        ),
                                      ),
                                    Positioned(
                                        top: 4,
                                        right: 10,
                                        child: Row(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: IconButton(
                                                onPressed: () {
                                                  deleteCarte(
                                                      cartesBancaires[index]
                                                          .cardId);
                                                  _refresh();
                                                },
                                                icon: Icon(Icons.delete),
                                                color: Colors.red[800],
                                                iconSize: 30,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: IconButton(
                                                onPressed: () {
                                                  changeDefault(
                                                      cartesBancaires[index]
                                                          .cardId);
                                                },
                                                icon: Icon(Icons.bookmark_add),
                                                color: Color.fromRGBO(
                                                    5, 12, 75, 1.0),
                                                iconSize: 30,
                                              ),
                                            ),
                                          ],
                                        ))
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Floating action button for adding new cards
        onPressed: () {
          Navigator.pushNamed(context, '/addCarte');
        },
        icon: const Icon(Icons.add),
        label: const Text("Ajouter une carte"),
      ),
    );
  }
}
