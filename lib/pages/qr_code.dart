import 'dart:io'; // Import necessary library for Platform

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const QR_Code());
}

class QR_Code extends StatelessWidget {
  const QR_Code({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(
        top: 10.0, left: 3.0, right: 3.0),);}


}

