import 'package:budgetbee/screens/loginorsignupscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginOrSignupPage(),
          ));
    });
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/Background.png'),
                fit: BoxFit.cover)),
        child: Center(
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Image(image: AssetImage('lib/assets/OldLogo.png')),
            ),
            Positioned(
                top: 505,
                bottom: 0,
                right: 0,
                left: 110,
                child: Text(
                  "Budget Better , Together",
                  style: GoogleFonts.comfortaa(),
                ))
          ],
        )),
      ),
    );
  }
}
