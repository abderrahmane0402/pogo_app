import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:example_app/services/CartService.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? sender_tel ;
  late final String amount;
  final TextEditingController _payTextEditingController = TextEditingController();
  late Future<Map<String, dynamic>?> _userDataFuture;
  CarteService carteService = CarteService();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    qrData = jsonDecode(widget.qrData);
    amount = widget.amount;
    _userDataFuture = getUserCard(qrData);
  }
  Future<Map<String, dynamic>?> getUserCard(Map<String, dynamic> qrData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      sender_tel = prefs.getString('user_tele') as String;

      // prefs.getInt(key)
      print(sender_tel);
      String userId = qrData['user_id'];
      String cardId = qrData['card_id'];

      // Call your API function to get user card
      return await carteService.getUserCarte(userId, cardId);

    } catch (error) {
      // Handle error, e.g., display error message
      print('Error fetching user card: $error');
      return null; // or throw an error if necessary
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
      body: Center(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
              return Text('Error fetching data');
            } else {


              // Data fetched successfully
              final userData = snapshot.data!['user'];
              final carteData = snapshot.data!['carte'];
              final transferFrom = sender_tel;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Confirmation',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),

                        SizedBox(height: 16),
                        buildInfoRow('Transfer from:', transferFrom!),

                        SizedBox(height: 8),
                        buildInfoRow('Transfer to:', userData['telephone'].toString()),
                        SizedBox(height: 8),
                        buildInfoRow('Amount', "DH $amount"),
                        SizedBox(height: 8),
                        buildInfoRow('Fee', "DH 0.1"),
                        SizedBox(height: 8),
                        buildInfoRow('Total amount', "DH ${(double.parse(amount) + 0.1).toStringAsFixed(2)}"),
                        SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle the confirm button press
                            },
                            child: Text('Confirm'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue, // text color
                              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
  Widget buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _payTextEditingController.dispose();
    super.dispose();
  }
}


