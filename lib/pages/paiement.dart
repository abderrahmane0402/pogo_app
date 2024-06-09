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
  final TextEditingController _payTextEditingController =
      TextEditingController();
  late Future<Map<String, dynamic>?> _userDataFuture;
  CarteService carteService = CarteService();

  @override
  void initState() {
    super.initState();
    qrData = jsonDecode(widget.qrData);
    amount = widget.amount;
    getUserCard(qrData);
  }

  void getUserCard(Map<String, dynamic> qrData) async {
    try {
      String userId = qrData['user_id'];
      String cardId = qrData['card_id'];

      // Call your API function to get user card
      _userDataFuture = carteService.getUserCarte(userId, cardId);
    } catch (error) {
      // Handle error, e.g., display error message
      print('Erreur lors de la récupération de la carte utilisateur: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Confirmation',
          style: TextStyle(color: Colors.black),
        ),
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else {
                  final userData = snapshot.data!['user'];
                  final carteData = snapshot.data!['carte'];
                  final String senderName = "zakia ouajih";
                  final String receiverName = "abderrahmane sabkari";

                  return Card(
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
                              color: Colors.grey[600],
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
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '$senderName',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Transfert a:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '$receiverName',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
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
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '$amount DH',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
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
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '6 DH',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
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
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '126 DH',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
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
                backgroundColor: Colors.green, // couleur de fond
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
