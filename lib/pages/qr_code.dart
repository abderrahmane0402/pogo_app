import 'dart:convert';

import 'package:example_app/services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/CartService.dart';

// Define the main function, which is the entry point of the Dart application
void main() {
  // Call the runApp function to start the Flutter application
  runApp(const QR_Code());
}

// Define a StatelessWidget to represent your app
class QR_Code extends StatelessWidget {
  const QR_Code({super.key});


  // Override the build method to describe the UI of your app
  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget, which is the root of your app's widget tree
    return  const QRCodeGeneratorPage();

  }
}

// Define a StatefulWidget for the QR Code Generator page
class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({super.key});


  @override
  _QRCodeGeneratorPageState createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  final storage = const FlutterSecureStorage();
  CarteService carteService = CarteService();
  AuthService authService = AuthService();
  late Map<String, String?> _qrData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      generateQrCode();
    });
    // generateQrCode();
  }

  void generateQrCode() async {
    try {
      setState(() {
        _isLoading = true;
      });

      String? authToken = await authService.getToken();

      var defaultCardResponse = await carteService.getDefaultCard(authToken!);

      if (defaultCardResponse != null && defaultCardResponse['statusCode'] == 201) {
        var defaultCardData = jsonDecode(defaultCardResponse['body']);
        var defaultCard = defaultCardData['carte'];
        print("Default card data: $defaultCard");

        if (defaultCard != null) {
          Map<String, dynamic> cardMap = defaultCard as Map<String, dynamic>;
          String? idCard = cardMap['_id'] as String?;
          print("Card ID: $idCard");

          if (idCard != null && idCard.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? userId = prefs.getString('user_id');
            print("User ID: $userId");

            setState(() {
              _qrData = {
                'user_id': userId,
                'card_id': idCard
              };
              _isLoading = false;
            });

          } else {
            setState(() {
              _isLoading = false;
            });
            print("Card ID is empty.");
            showErrorDialog('Card ID is empty.');
            return; // Exit the function early
          }
        } else {
          // Handle case when defaultCard is null
          print('Default card data is null');
          showErrorDialog('Default card data is null.');
          setState(() {
            _isLoading = false;
          });
          return; // Exit the function early
        }
      } else {
        // Handle case when defaultCardResponse is null or  code is not 201
        print('Failed to get default card data');
        showErrorDialog('Failed to get default card data.');
        setState(() {
          _isLoading = false;
        });
        return; // Exit the function early
      }
    } catch (e) {
      print('Error generating QR code: $e');
      showErrorDialog('Error generating QR code.');
      setState(() {
        _isLoading = false;
      });
    }
  }


  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/Home');
              },
            ),
          ],
        );
      },
    );
  }


  @override
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_qrData.isNotEmpty)
              QrImageView(
                data: jsonEncode(_qrData),
                version: QrVersions.auto,
                size: 200.0,
              ),
            if (_isLoading) // Display loading indicator if isLoading is true
              const CircularProgressIndicator(),
            const SizedBox(height: 20),
            if (_qrData.isEmpty &&
                !_isLoading) // Show error message only if not loading
              const SizedBox(height: 40),
            ElevatedButton(
              onPressed: generateQrCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(5, 12, 75, 1.0),
                // Background color
                textStyle: TextStyle(color: Colors.white),
                // Text color
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                // Button padding
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8)), // Button border radius
              ),
              child: const Text(
                  'Regenerate QR Code', style: TextStyle(color: Colors.white)),
              // Text for the button
            ),
          ],
        ),
      ),
    );
  }

}