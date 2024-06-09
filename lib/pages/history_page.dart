import 'package:flutter/material.dart';

void main() {
  runApp(History());
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
          title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8),
          children: [
            HistoryItemCard(
              name: 'Zakia',
              status: 'Completed',
              amount: '100',
            ),
            HistoryItemCard(
              name: 'John Doe',
              status: 'Pending',
              amount: '200',
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryItemCard extends StatelessWidget {
  final String name;
  final String status;
  final String amount;

  const HistoryItemCard({
    Key? key,
    required this.name,
    required this.status,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Color.fromRGBO(30, 157, 151, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: $name', style: TextStyle(color: Colors.white)),
                  Text(
                    'Status: $status',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text('Amount: $amount', style: TextStyle(fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {
                  // Action when button is clicked
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Transaction Details'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Name: $name'),
                            Text('Status: $status'),
                            Text('Amount: $amount'),
                            // Add more Text widgets for additional items
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return Color.fromRGBO(5, 12, 75, 1.0); // Your desired color
                    },
                  ),
                ),
                child: Text('Voir details', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
