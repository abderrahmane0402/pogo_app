import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCarteBancaire extends StatefulWidget {
  const AddCarteBancaire({super.key});

  @override
  State<AddCarteBancaire> createState() => _AddCarteBancaireState();
}

class _AddCarteBancaireState extends State<AddCarteBancaire> {
  final TextEditingController nomProprietaireController =
      TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController dateExpirationController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    // Dispose des contrôleurs lorsqu'ils ne sont plus utilisés
    nomProprietaireController.dispose();
    numeroController.dispose();
    dateExpirationController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Ajouter une carte bancaire',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 220,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Color.fromRGBO(54, 54, 54, 1.0),
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "....  ....  ....  ....",
                        style: TextStyle(


                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Valid to",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "15/02/2025",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CVV",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "...",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nom du propriétaire',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: nomProprietaireController,
                    decoration: const InputDecoration(
                      hintText: 'Nom complet',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Numéro de carte',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: numeroController,
                    decoration: const InputDecoration(
                      hintText: '1234 5678 9012 3456',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Date d\'expiration',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: dateExpirationController,
                              decoration: const InputDecoration(
                                hintText: 'MM/YY',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CVV',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: cvvController,
                              decoration: const InputDecoration(
                                hintText: '123',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromRGBO(54, 54, 54, 1.0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      5.0), // Adjust the value to your preference
                ),
              ),
            ),
            onPressed: () {
              // Action to be performed when the button is pressed
            },
            child: Text(
              'Ajouter la carte bancaire',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
