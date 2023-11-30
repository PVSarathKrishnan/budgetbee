import 'package:budgetbee/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 200,),
              Container(
                
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      height: 200,
                      width: 200,
                      child: Image(image: AssetImage("lib/assets/Logo.png"))),
                    SizedBox(height: 10,),
                  ],
                ),
                ),
              Container(
                width: 280,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                      Text(
                        "Hello " ,
                        style: GoogleFonts.dancingScript(
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: [
                            Lottie.asset("lib/assets/Loading.json", height: 100,width: 180)
                          ],
                    )
                    )
                    ]
                    )
                    )
            ]
            )
            )
            )
            );
          
                    
 
 
  }
}