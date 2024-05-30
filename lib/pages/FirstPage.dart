import 'package:flutter/material.dart';

void main() {
  runApp(const FirstPage());
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: Image.asset(
                  'assets/images/pogo.png',
                  width: 250,
                  height: 117,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Réglez vos courses en un clin d'œil, où que vous soyez !",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const SizedBox(width: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Image.asset(
                  'assets/images/img2.png',
                  width: 459,
                ),
              ),
              // const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/beforeLogin');
                },
                child: Container(
                  width: 46,
                  height: 46,
                  margin:
                      const EdgeInsets.only(top: 16), // Add margin as needed
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(44, 176, 145, 1.0),
                  ),
                  child: const Icon(
                    Icons.navigate_next_rounded,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
