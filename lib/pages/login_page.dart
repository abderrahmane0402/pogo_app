import 'dart:convert';
import 'package:example_app/services/CartService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/AuthenticationService.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      routes: {
        '/Home': (context) => Home(),
      },
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  late TextEditingController _telTextEditingController;
  late TextEditingController _passwordTextEditingController;

  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  AuthService authService = AuthService();
  CarteService carteService = CarteService();

  @override
  void initState() {
    super.initState();
    _telTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _telTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void loginUser() async {
    String login = _telTextEditingController.text;
    String password = _passwordTextEditingController.text;

    try {
      final response = await authService.login(login, password);

      if (response != null) {
        if (response.statusCode == 200) {
          Navigator.pushReplacementNamed(context, '/Home');
        } else if (response.statusCode == 400) {
          var responseBody = jsonDecode(response.body);
          String errorMessage = responseBody['message'];
          print('Error message: $errorMessage');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        } else {
          // Handle unexpected status codes
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected status code: ${response.statusCode}')),
          );
        }
      } else {
        // Handle null response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No response received. Please check your internet connection.')),
        );
      }
    } catch (e) {
      print('Error in loginUser: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
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
                  'Se connecter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 50),
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
                      labelText: 'téléphone',
                      // hintText: '06xxxxxxxx',
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
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      filled: true,
                      fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                      labelText: 'mot de passe',
                      // hintText: 'password',
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
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      loginUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(5, 12, 79, 1.0),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
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
