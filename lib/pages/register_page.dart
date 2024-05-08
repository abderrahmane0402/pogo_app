import 'package:flutter/material.dart';

void main() {
  runApp(Register());
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _nomTextEditingController;
  late TextEditingController _prenomTextEditingController;
  late TextEditingController _telTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;

  @override
  void initState() {
    super.initState();
    _nomTextEditingController = TextEditingController();
    _prenomTextEditingController = TextEditingController();
    _telTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _nomTextEditingController.dispose();
    _prenomTextEditingController.dispose();
    _telTextEditingController.dispose();
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
                "S'inscrire",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
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
                            padding: EdgeInsets.all(8), // Adjust padding as needed
                            child: Icon(
                              Icons.person, // Icon for email input
                              color: Color.fromRGBO(5, 12, 79, 1.0), // Color of the icon
                              size: 25, // Size of the icon
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Add some spacing between the two text fields
                    Expanded(
                      child: TextField(
                        controller: _prenomTextEditingController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          filled: true,
                          fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                          labelText: 'Votre prenom',
                          hintText: 'prenom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _telTextEditingController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    filled: true,
                    fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                    labelText: 'Enter votre telephone',
                    hintText: '06xxxxxxxx',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8), // Adjust padding as needed
                      child: Icon(
                        Icons.phone, // Icon for email input
                        color: Color.fromRGBO(5, 12, 79, 1.0), // Color of the icon
                        size: 25, // Size of the icon
                      ),
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 5),
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
                  backgroundColor:  Colors.white, // Background color
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
                  'Login',
                  style: TextStyle(color: Color.fromRGBO(5, 12, 79, 1.0)), // Text color
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
