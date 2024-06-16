import 'package:example_app/pages/paiement.dart';
import 'package:flutter/material.dart';

class PaymentInputPage extends StatelessWidget {
  final String qrData;

  PaymentInputPage({required this.qrData, required void Function() closeScreen});

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Entrer le montant a payer'),
            SizedBox(height: 20.0),
            // Text(qrData),
            SizedBox(height: 16.0),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Enter le montant',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.money,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),


              ),
            ),
            SizedBox(height: 30.0),
        ElevatedButton(
          onPressed: () {
            String amount = amountController.text;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Paiement(
                  qrData: qrData,
                  amount: amount,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          backgroundColor: Color.fromRGBO(5, 12, 75, 1.0), // foreground color (text color)
            padding: EdgeInsets.symmetric(horizontal: 20),
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Color.fromRGBO(5, 12, 75, 1.0), width: 2), // border color and width
            ),
          ),
          child: Text('passer au paiement'),
        ),

      ]),)
    );
  }
}
