import 'package:flutter/material.dart';

void main() {
  runApp(History());
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual count of history items
        itemBuilder: (BuildContext context, int index) {
          return HistoryItemCard(
            index: index,
            name: 'zakia',
            status: 'completed',
            amount: '100',
          );
        },
      ),
    );
  }
}

class HistoryItemCard extends StatelessWidget {
  final int index;
  final String name;
  final String status;
  final String amount;

  const HistoryItemCard({
    Key? key,
    required this.index,
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
                  Text('Name: $name' , style: TextStyle(color: Colors.white),),
                  Text(
                    'Status: $status',
                    style: TextStyle(fontSize: 12,  color: Colors.white),
                  ),
                  Text('amount : $amount', style: TextStyle(fontSize: 12, color: Colors.white),),
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
                        title: Text('info transaction'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Transaction ID: 12345'),
                            // Text('sent'),
                            Text('Name: John Doe'),
                            Text('received: zakia'),
                            Text('Amount: \$100'),
                            Text('Date: 2023-03-12'),
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

