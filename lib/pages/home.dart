import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 10.0,left: 3.0, right: 3.0), // Adjust the value as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the top of the column
        children: [
           SizedBox(
            height: 200,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(5, 12, 79, 1.0),
                borderRadius: BorderRadius.circular(30.0),
              ),
              alignment: Alignment.topCenter, // Align the child to the top
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0), // Add padding to the top
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            'Votre sécurité est notre priorité.',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: 150, // Set your desired width here
                        child: Divider(
                          height: 20, // Set your desired height for the line
                          thickness: 2, // Set your desired thickness for the line
                          color: Colors.white, // Set your desired color for the line
                        ),
                      ),),
                      Padding(
                        padding:  EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: 150, // Set your desired width here
                        child: Text(
                          'Profitez de transactions sûres avec notre application mobile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 12
                          ),
                        ),
                      ),),
                    ],
                  ),

                   Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Image.asset('assets/images/home.png', width: 165),

                  ),
                ],
              ),
            ),
          ),
          // Add more widgets here if needed
        ],
      ),
    );


  }
}
