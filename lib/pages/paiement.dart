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
      print('Error fetching user card: $error');
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display QR code data
          FutureBuilder<Map<String, dynamic>?>(
            future: _userDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Data fetched successfully
                final userData = snapshot.data!['user'];
                final carteData = snapshot.data!['carte'];

                return Column(
                  children: [
                    Text('User: $userData'),
                    Text('Carte: $carteData'),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _payTextEditingController.dispose();
    super.dispose();
  }
}
