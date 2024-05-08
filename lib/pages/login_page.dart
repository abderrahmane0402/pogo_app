import 'package:flutter/material.dart';

void main() {
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
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
                child: TextField(
                  controller: _emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                    labelText: 'Enter votre email',
                    hintText: 'example@example.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8), // Adjust padding as needed
                      child: Icon(
                        Icons.email, // Icon for email input
                        color: Color.fromRGBO(5, 12, 79, 1.0), // Color of the icon
                        size: 25, // Size of the icon
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
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
                      padding: EdgeInsets.all(8), // Adjust padding as needed
                      child: Icon(
                        Icons.remove_red_eye, // Icon for email input
                        color: Color.fromRGBO(5, 12, 79, 1.0), // Color of the icon
                        size: 25, // Size of the icon
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Perform login/authentication logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(5, 12, 79, 1.0), // Background color
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Button border radius
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white), // Text color
            ),
          ),

            ],
          ),
        ),
      ),
    );
  }
}
