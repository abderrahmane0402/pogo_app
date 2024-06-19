import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:example_app/services/CartService.dart';

class Paiement extends StatefulWidget {
  final String qrData;
  final String amount;

  const Paiement({
    Key? key,
    required this.qrData,
    required this.amount,
  }) : super(key: key);

  @override
  _PaiementState createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  late final Map<String, dynamic> qrData;
  late final String amount;
  late final int amountInt;

  late final double feeRate = 0.06;
  late final String fee = feeRate.toString();
  late final double total;

  final TextEditingController _payTextEditingController =
      TextEditingController();
  late Future<Map<String, dynamic>?> _userDataFuture;
  CarteService carteService = CarteService();

  @override
  void initState() {
    super.initState();
    qrData = jsonDecode(widget.qrData);
    amount = widget.amount;
    _userDataFuture = getUserCard(qrData);
    totalAmount();
  }

  double totalAmount() {
    amountInt = int.parse(amount);
    total = amountInt + (amountInt * feeRate);
    return total;
  }

  Future<Map<String, dynamic>?> getUserCard(Map<String, dynamic> qrData) async {
    try {
      // Ensure qrData contains required keys
      if (!qrData.containsKey('user_id') || !qrData.containsKey('card_id')) {
        print('Invalid QR data: missing user_id or card_id');
        return null;
      }

      // Retrieve userId and cardId from qrData
      final String userId = qrData['user_id'];
      final String cardId = qrData['card_id'];

      // Call your API function to get user card
      final response = await carteService.getUserCarte(userId, cardId);

      if (response != null) {
        return response;
      } else {
        print('Failed to retrieve user card: response is null');
        return null;
      }
    } catch (error) {
      // Handle error, e.g., display error message
      print('Error while retrieving user card: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<Map<String, dynamic>?>(
              future: _userDataFuture,
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(
                      child: Text("aucun donne trouver sur l'utilisateur"));
                } else {
                  final String senderName = "zakia ouajih";
                  final String receiverName = "abderrahmane sabkari";

                  return Card(
                    color: Color.fromRGBO(30, 157, 151, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Veuillez confirmer la transaction suivante :',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transfert de:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '$senderName',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Transfert a:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '$receiverName',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Divider(),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Montant',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$amount DH',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Frais',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$fee %',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Montant total',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$total DH',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Logique de confirmation de paiement
                print('Paiement confirmé');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromRGBO(5, 12, 75, 1.0), // couleur de fond
                foregroundColor: Colors.white, // couleur du texte
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _payTextEditingController.dispose();
    super.dispose();
  }
}
