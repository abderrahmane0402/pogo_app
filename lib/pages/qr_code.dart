import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  TextEditingController _controller = TextEditingController();
  String _qrData = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter data to encode',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrData = _controller.text;
                });
              },
              child: const Text('Generate QR Code'),
            ),
            const SizedBox(height: 20),
            if (_qrData.isNotEmpty)
              QrImageView(
                data: _qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),

          ].cast<Widget>(), // Ensure the list contains only widgets
        ),
    );
  }
}
