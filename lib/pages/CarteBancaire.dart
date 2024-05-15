import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarteBancaireModel {
  final String cardNumber;
  final String expirationDate;

  CarteBancaireModel({required this.cardNumber, required this.expirationDate});
}

class CarteBancaire extends StatefulWidget {
  const CarteBancaire({super.key});

  @override
  State<CarteBancaire> createState() => _CarteBancaireState();
}

class _CarteBancaireState extends State<CarteBancaire> {
  List<CarteBancaireModel> cartesBancaires = [
    CarteBancaireModel(
        cardNumber: "1234 5678 9012 3456", expirationDate: "12/25"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
    CarteBancaireModel(
        cardNumber: "9876 5432 1098 7654", expirationDate: "03/27"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Vos Cartes bancaires",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500, // Texte en vert d'eau
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartesBancaires.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            leading: const Icon(Icons.credit_card),
                            title: Text(cartesBancaires[index].cardNumber),
                            subtitle: Text(
                                "Expire le: ${cartesBancaires[index].expirationDate}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  cartesBancaires.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Floating action button for adding new cards
        onPressed: () {
          Navigator.pushNamed(context, '/addCarte');
        },
        icon: const Icon(Icons.add),
        label: const Text("Ajouter une carte"),
      ),
    );
  }
}
