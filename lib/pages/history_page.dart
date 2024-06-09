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
            historyItem: 'History Item $index',
            specificDetails: 'Specific Details for Item $index',
          );
        },
      ),
    );
  }
}

class HistoryItemCard extends StatelessWidget {
  final int index;
  final String historyItem;
  final String specificDetails;

  const HistoryItemCard({
    Key key = const Key('history_item_card'),
    required this.index,
    required this.historyItem,
    required this.specificDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListTile(
              title: Text(historyItem),
              subtitle: Text(specificDetails, style: TextStyle(fontSize: 12),),
              // date:Text('2023/03/12'),
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
                        title: Text('Button Clicked'),
                        content: Text('Button in card $index clicked!'),
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
                child: Text('Voir details', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
