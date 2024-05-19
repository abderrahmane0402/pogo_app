import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: PhoneForm(),
  ));
}

class PhoneForm extends StatefulWidget {
  const PhoneForm({Key? key}) : super(key: key);

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  late TextEditingController _telTextEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _telTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _telTextEditingController.dispose();
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Vérifier Votre Téléphone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _telTextEditingController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      filled: true,
                      fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                      labelText: 'Entrez votre téléphone',
                      hintText: '06xxxxxxxx',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(8), // Adjust padding as needed
                        child: Icon(
                          Icons.phone, // Icon for phone input
                          color: Color.fromRGBO(5, 12, 79, 1.0), // Color of the icon
                          size: 25, // Size of the icon
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre téléphone';
                      }
                      if (!RegExp(r'^06\d{8}$').hasMatch(value)) {
                        return 'Veuillez entrer un numéro de téléphone valide';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Perform registration logic here
                      Navigator.pushNamed(context, '/verifier_phone');
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Enregistrement réussi')),
                      // );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color.fromRGBO(5, 12, 79, 1.0),
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Suivant',
                    style: TextStyle(color: Color.fromRGBO(5, 12, 79, 1.0)), // Text color
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
