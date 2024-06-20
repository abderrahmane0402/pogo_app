import 'package:example_app/services/PaimentService.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<Map<String, dynamic>?> _Data;
  PaymentService paymentService = PaymentService();
  @override
  void initState() {
    super.initState();
    _Data = paymentService.getHistorique();
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
      body: FutureBuilder(
          future: _Data,
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('No data available'),
              );
            }

            print(snapshot.data?["historique"][0]);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?["historique"].length,
                  itemBuilder: (context, index) {
                    return HistoryItemCard(
                      name: snapshot.data?["historique"][index]["destinataire"]
                          ["nom"],
                      status: snapshot.data?["historique"][index]
                          ["Etat_de_la_transaction"],
                      amount: snapshot.data?["historique"][index]["montant"]
                          ["\$numberDecimal"],
                      telephone: snapshot.data?["historique"][index]
                          ["destinataire"]["telephone"],
                      prenom: snapshot.data?["historique"][index]
                          ["destinataire"]["prenom"],
                      remarque: snapshot.data?["historique"][index]["remarque"],
                    );
                  }),
            );
          }),
    );
  }
}

class HistoryItemCard extends StatelessWidget {
  final String name;
  final String status;
  final String amount;
  final int telephone;
  final String prenom;
  final String remarque;

  const HistoryItemCard(
      {Key? key,
      required this.name,
      required this.status,
      required this.amount,
      required this.telephone,
      required this.prenom,
      required this.remarque})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Color.fromRGBO(30, 157, 151, 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom: $name',
                      style: TextStyle(color: Colors.white, fontSize: 13)),
                  Text(
                    'Status: $status',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  Text('Montant: $amount DH',
                      style: TextStyle(fontSize: 13, color: Colors.white)),
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
                        title: Text('détails de la transaction'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Nom: $name', style: TextStyle(fontSize: 20)),
                            Text('Prenom: $prenom',
                                style: TextStyle(fontSize: 20)),
                            Text('Telephone: 0$telephone',
                                style: TextStyle(fontSize: 20)),
                            Text('Status: $status',
                                style: TextStyle(fontSize: 20)),
                            Text('Montant: $amount DH',
                                style: TextStyle(fontSize: 20)),
                            Text('Remarque: $remarque',
                                style: TextStyle(fontSize: 20)),
                            // Add more Text widgets for additional items
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Color.fromRGBO(
                          5, 12, 75, 1.0); // Your desired color
                    },
                  ),
                ),
                child: Text('Voir details',
                    style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
