import 'dart:convert';
import 'package:example_app/services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:example_app/config/url.dart';

void main() {
  runApp( MaterialApp(

    home: Register(),
  ));
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _nomTextEditingController;
  late TextEditingController _prenomTextEditingController;
  late TextEditingController _telTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late TextEditingController _confirmPasswordTextEditingController;
  late TextEditingController _ribTextEditingController;
  late TextEditingController _cardNumberTextEditingController;
  late TextEditingController _expiryDateTextEditingController;
  late TextEditingController _cvvTextEditingController;

  bool _isRIBVisible = false;
  int _currentStep = 0;

  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _nomTextEditingController = TextEditingController();
    _prenomTextEditingController = TextEditingController();
    _telTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _confirmPasswordTextEditingController = TextEditingController();
    _ribTextEditingController = TextEditingController();
    _cardNumberTextEditingController = TextEditingController();
    _expiryDateTextEditingController = TextEditingController();
    _cvvTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _nomTextEditingController.dispose();
    _prenomTextEditingController.dispose();
    _telTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmPasswordTextEditingController.dispose();
    _ribTextEditingController.dispose();
    _cardNumberTextEditingController.dispose();
    _expiryDateTextEditingController.dispose();
    _cvvTextEditingController.dispose();
    super.dispose();
  }

  void registerUser() async {
    var nom = _nomTextEditingController.text;
    var prenom = _prenomTextEditingController.text;
    var telephone = _telTextEditingController.text;
    var password = _passwordTextEditingController.text;
    var confirmePassword = _confirmPasswordTextEditingController.text;



    if (password != confirmePassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
      return;
    }

    try {
      var response = await authService.register(nom, prenom, telephone, password, confirmePassword);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enregistrement réussi')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Échec de l\'enregistrement: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite: $e')),
      );
    }
  }

  List<Step> _steps() {
    return [
      Step(
        title: const Icon(
          Icons.person,
          color: Color.fromRGBO(5, 12, 79, 1.0),
          size: 20,
        ),
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: _nomTextEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Votre nom',
                hintText: 'nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.person,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }
                if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                  return 'Veuillez entrer seulement des lettres';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _prenomTextEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Votre prenom',
                hintText: 'prenom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.person,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }
                if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                  return 'Veuillez entrer seulement des lettres';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _telTextEditingController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Enter votre téléphone',
                hintText: '06xxxxxxxx',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.phone,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre téléphone';
                }
                if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Veuillez entrer un numéro de téléphone valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordTextEditingController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Enter votre password',
                hintText: 'password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre password';
                }
                if (value.length < 8) {
                  return 'Le mot de passe doit contenir au moins 8 caractères';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _confirmPasswordTextEditingController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Confirmer votre password',
                hintText: 'confirm password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez confirmer votre password';
                }
                if (value != _passwordTextEditingController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Icon(
          Icons.credit_card,
          color: Color.fromRGBO(5, 12, 79, 1.0),
          size: 20,
        ),
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: _cardNumberTextEditingController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.credit_card,
                    color: Color.fromRGBO(5, 12, 79, 1.0),
                    size: 25,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre numéro de carte';
                }
                if (!RegExp(r'^\d{16}$').hasMatch(value)) {
                  return 'Veuillez entrer un numéro de carte valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _expiryDateTextEditingController,
              keyboardType: TextInputType.datetime,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'Expiry Date',
                hintText: 'MM/YY',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer la date d\'expiration de la carte';
                }
                if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                  return 'Veuillez entrer une date d\'expiration valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _cvvTextEditingController,
              keyboardType: TextInputType.number,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'CVV',
                hintText: '123',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le CVV';
                }
                if (!RegExp(r'^\d{3}$').hasMatch(value)) {
                  return 'Veuillez entrer un CVV valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

          ],
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Icon(
          Icons.credit_score_outlined,
          color: Color.fromRGBO(5, 12, 79, 1.0),
          size: 20,
        ),
        content: Column(
          children: <Widget>[
            TextFormField(
              controller: _ribTextEditingController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                labelText: 'RIB',
                hintText: 'RIB',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le RIB';
                }
                return null;
              },
            ),
          ],
        ),
        isActive: _currentStep >= 2,
        state: _currentStep == 2 ? StepState.indexed : StepState.complete,
      ),
    ];
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
          child: Theme(
            data: ThemeData(
              canvasColor: Color.fromRGBO(223, 245, 241, 1.0),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Color.fromRGBO(5, 12, 75, 1.0),
                  background: Colors.red,
                  secondary: Color.fromRGBO(5, 12, 75, 1.0),
                 ),
                ),
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep < _steps().length - 1) {
                    setState(() {
                      _currentStep += 1;
                    });
                  } else {
                    registerUser();
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
                steps: _steps(),
                type: StepperType.horizontal,

              )),
        )

    );


  }
}

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const Text(
// "S'inscrire",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 25,
// ),
// ),
// const SizedBox(height: 10),
// Padding(
// padding: const EdgeInsets.all(16),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// // Nom input
// Expanded(
// child: TextFormField(
// controller: _nomTextEditingController,
// keyboardType: TextInputType.text,
// textInputAction: TextInputAction.next,
// decoration: InputDecoration(
// contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// filled: true,
// fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
// labelText: 'Votre nom',
// hintText: 'nom',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30),
// borderSide: BorderSide.none,
// ),
// prefixIcon: const Padding(
// padding: EdgeInsets.all(8),
// child: Icon(
// Icons.person,
// color: Color.fromRGBO(5, 12, 79, 1.0),
// size: 25,
// ),
// ),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Veuillez entrer votre nom';
// }
// if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
// return 'Veuillez entrer seulement des lettres';
// }
// return null;
// },
// ),
// ),
// const SizedBox(width: 16),
// // Prénom input
// Expanded(
// child: TextFormField(
// controller: _prenomTextEditingController,
// keyboardType: TextInputType.text,
// textInputAction: TextInputAction.next,
// decoration: InputDecoration(
// contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// filled: true,
// fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
// labelText: 'Votre prénom',
// hintText: 'prénom',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30),
// borderSide: BorderSide.none,
// ),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Veuillez entrer votre prénom';
// }
// if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
// return 'Veuillez entrer seulement des lettres';
// }
// return null;
// },
// ),
// ),
// ],
// ),
// ),
// // Phone input
// Padding(
// padding: const EdgeInsets.all(16),
// child: TextFormField(
// controller: _telTextEditingController,
// keyboardType: TextInputType.phone,
// textInputAction: TextInputAction.next,
// decoration: InputDecoration(
// contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// filled: true,
// fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
// labelText: 'Enter votre téléphone',
// hintText: '06xxxxxxxx',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30),
// borderSide: BorderSide.none,
// ),
// prefixIcon: const Padding(
// padding: EdgeInsets.all(8),
// child: Icon(
// Icons.phone,
// color: Color.fromRGBO(5, 12, 79, 1.0),
// size: 25,
// ),
// ),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Veuillez entrer votre téléphone';
// }
// if (!RegExp(r'^\d{10}$').hasMatch(value)) {
// return 'Veuillez entrer un numéro de téléphone valide';
// }
// return null;
// },
// ),
// ),
//
//
// // Password input
// Padding(
// padding: const EdgeInsets.all(16),
// child: TextFormField(
// controller: _passwordTextEditingController,
// obscureText: true,
// textInputAction: TextInputAction.done,
// decoration: InputDecoration(
// contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// filled: true,
// fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
// labelText: 'Enter votre password',
// hintText: 'password',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30),
// borderSide: BorderSide.none,
// ),
// prefixIcon: const Padding(
// padding: EdgeInsets.all(8),
// child: Icon(
// Icons.lock,
// color: Color.fromRGBO(5, 12, 79, 1.0),
// size: 25,
// ),
// ),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Veuillez entrer votre password';
// }
// if (value.length < 8) {
// return 'Le mot de passe doit contenir au moins 8 caractères';
// }
// return null;
// },
// ),
// ),
// // Confirm password input
// Padding(
// padding: const EdgeInsets.all(16),
// child: TextFormField(
// controller: _confirmPasswordTextEditingController,
// obscureText: true,
// textInputAction: TextInputAction.done,
// decoration: InputDecoration(
// contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// filled: true,
// fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
// labelText: 'Confirmer votre password',
// hintText: 'confirm password',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30),
// borderSide: BorderSide.none,
// ),
// prefixIcon: const Padding(
// padding: EdgeInsets.all(8),
// child: Icon(
// Icons.lock,
// color: Color.fromRGBO(5, 12, 79, 1.0),
// size: 25,
// ),
// ),
// ),
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Veuillez confirmer votre password';
// }
// if (value != _passwordTextEditingController.text) {
// return 'Les mots de passe ne correspondent pas';
// }
// return null;
// },
// ),
// ),
// SwitchListTile(
// title: Text('Ajouter RIB : '),
// value: _isRIBVisible,
// onChanged: (bool value) {
// setState(() {
// _isRIBVisible = value;
// });
// },
// activeColor: Color.fromRGBO(223, 245, 241, 1.0),        // Color of the thumb when the switch is on
// activeTrackColor: Color.fromRGBO(5, 12, 75, 1.0), // Color of the track when the switch is on
// inactiveThumbColor: Colors.grey,  // Color of the thumb when the switch is off
// inactiveTrackColor: Colors.grey[300],
// ),
// if (_isRIBVisible)
// Padding(
// padding: const EdgeInsets.all(16),
// child:
// TextField(
// keyboardType: TextInputType.number,
// decoration:InputDecoration(
// contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// filled: true,
// fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
// labelText: 'Ajouter RIB',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(30),
// borderSide: BorderSide.none,
// ),
// prefixIcon: const Padding(
// padding: EdgeInsets.all(8),
// child: Icon(
// Icons.credit_card,
// color: Color.fromRGBO(5, 12, 79, 1.0),
// size: 25,
// ),
// ),
// ),
// ),
// ),
// const SizedBox(height: 30),
// ElevatedButton(
// onPressed: () {
// if (_formKey.currentState?.validate() ?? false) {
// registerUser();
// }
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
// padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(30),
// side: const BorderSide(
// color: Color.fromRGBO(5, 12, 79, 1.0),
// width: 2.0,
// ),
// ),
// ),
// child: const Text(
// 'Register',
// style: TextStyle(color: Color.fromRGBO(5, 12, 79, 1.0)),
// ),
// ),
// ],
// ),