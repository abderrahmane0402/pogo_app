import 'package:flutter/material.dart';


void main() {
  runApp(const FirstPage());
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromRGBO(223, 245, 241, 1.0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/pogo.png',width: 250,height: 180,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Réglez vos courses en un clin d'œil, où que vous soyez !",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    height: 1.3,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40) ,
                child: Image.asset('assets/images/img2.png',width: 469,height: 373),
              ),


              Container(
                width: 60, // Adjust width as needed
                height: 60, // Adjust height as needed
                // padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(44,176,145,1.0), // Adjust color as needed
                ),
                child: const Icon(
                  Icons.navigate_next_rounded, // Specify the icon you want
                  color: Colors.black, // Adjust icon color as needed
                  size: 50, // Adjust icon size as needed
                ),
              )
            ],
          )

        ),
      ),
    );
  }
}
