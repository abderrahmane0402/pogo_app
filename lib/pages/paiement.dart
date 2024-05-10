// Importing necessary libraries
import 'package:flutter/material.dart';

// Define the main function, which is the entry point of the Dart application
void main() {
  // Call the runApp function to start the Flutter application
  runApp(const Paiement());
}

// Define a StatelessWidget to represent your app
class Paiement extends StatelessWidget {
  const Paiement({super.key});

  // Override the build method to describe the UI of your app
  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget, which is the root of your app's widget tree
    return MaterialApp(
      // Define the home property to specify the widget that will be the home screen of your app
      home: Scaffold(
        // Scaffold provides a basic layout structure for your app, including app bar, body, and more
        appBar: AppBar(
          // AppBar displays a toolbar at the top of the screen
          title: Text('My App'), // Title of the app bar
        ),
        body: Center(
          // Center widget centers its child widget horizontally and vertically
          child: Text(
            'Hello, World!', // Text widget to display a message
            style: TextStyle(fontSize: 24), // Style for the text
          ),
        ),
      ),
    );
  }
}
