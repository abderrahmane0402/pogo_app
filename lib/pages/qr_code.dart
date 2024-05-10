// Importing necessary libraries
import 'package:flutter/material.dart';

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
    return const Center(
      child: Text(
        'Hello, World!',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
