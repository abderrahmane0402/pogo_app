import 'package:example_app/pages/scan_qr_code.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Paiement());
}

class Paiement extends StatefulWidget {
  const Paiement({Key? key}) : super(key: key);

  @override
  _PaiementState createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {
  final TextEditingController _payTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Prêt à payer !",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50,),
        Padding(
          padding: const EdgeInsets.all(26),
          child: TextField(
            controller: _payTextEditingController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 17),
              filled: true,
              fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
              labelText: 'Montant à payer ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.payments,
                  color: Color.fromRGBO(5, 12, 79, 1.0),
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QRScanner()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color.fromRGBO(5, 12, 79, 1.0), // Background color
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Scanner QR code',
            style: TextStyle(color: Colors.white), // Text color
          ),
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
