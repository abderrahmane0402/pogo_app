import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:example_app/pages/scan_qr_code.dart';

class QRResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const QRResult({
    super.key,
    required this.code,
    required this.closeScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar:AppBar(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            QrImageView(
              data: "",
              size: 250,
              version: QrVersions.auto,
            ),
            const Text(
              "Scanned QR",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 11
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(5, 12, 79, 1.0)
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: const Text(
                    "Copy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
