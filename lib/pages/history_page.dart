import 'package:flutter/material.dart';

// Define the main function, which is the entry point of the Dart application
void main() {
  // Call the runApp function to start the Flutter application
  runApp(History());
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return a MaterialApp widget, which is the root of your app's widget tree
    return MaterialApp(
      home: HistoryPage(),
    );
  }
}

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // TODO: Implement methods to fetch history data

  @override
  void initState() {
    super.initState();
    // Call method to fetch history data here
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
    body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display history items here
            Text(
              'History Items',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Add a ListView to display history items
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with actual count of history items
                itemBuilder: (BuildContext context, int index) {
                  // TODO: Build each history item widget
                  return ListTile(
                    title: Text('History Item $index'),
                  );
                },
              ),
            ),
          ],
        )));

  }
}
