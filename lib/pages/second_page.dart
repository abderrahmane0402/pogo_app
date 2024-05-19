import 'package:flutter/material.dart';

void main() {
  runApp(const SecondPage());
}
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png',width: 120,height: 50,),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenue',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),),
            const SizedBox(height: 50),
            const Text(
              textAlign: TextAlign.center,
              'Ravi de vous revoir !',
              style: TextStyle(
                fontSize: 17,
                height: 1.5,
              ),),
            const Text(
              textAlign: TextAlign.center,
              'Connectez-vous pour continuer.',
              style: TextStyle(
                fontSize: 17,
                height: 1.5,
              ),),

            // const SizedBox(height: 20),
            Container(
              padding:  const EdgeInsets.symmetric(horizontal: 40) ,
              child: Image.asset('assets/images/img1.png',width: 469,),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                    width: 120, // Adjust width as needed
                    height: 40, // Adjust height as needed
                    decoration:  BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color.fromRGBO(44, 176, 145, 1.0),
                      borderRadius: BorderRadius.circular(20),// Adjust color as needed
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'se connecter',
                      style: TextStyle(
                          color: Colors.white,

                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/phone_number');
                  },
                  child: Container(
                    width: 120, // Adjust width as needed
                    height: 40, // Adjust height as needed
                    decoration:  BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromRGBO(44, 176, 145, 1.0), // Specify border color here
                        width: 2, // Specify border width here
                      ),// Adjust color as needed
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "s'inscrire",
                      style: TextStyle(
                        color: Color.fromRGBO(44, 176, 145, 1.0),

                      ),
                    ),
                  ),
                ),// Add some space between the GestureDetector and SizedBox
              ],
            ),


          ],
        ),
      ),
    );
  }
}
