// Importing necessary libraries
import 'package:flutter/material.dart';

// Define the main function, which is the entry point of the Dart application
void main() {
  // Call the runApp function to start the Flutter application
  runApp(const Home());
}

// Define a StatelessWidget to represent your app
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
          title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        ),
        body: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 24), // Style for the text
          ),
        ),
      ),
    );
  }
}
