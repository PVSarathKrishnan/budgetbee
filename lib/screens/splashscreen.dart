import 'package:budgetbee/screens/loginorsignupscreen.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image(image: AssetImage('lib/assets/Logo.png'))),
              SizedBox(height: 15,),
            Text(
              "Budget Better , Together",
              style: text_theme_p(),
            )
          ],
        )),
      ),
    );
  }

  // Future<void> gotoLogin() async{
  //   await Future.delayed(Duration(seconds: 5));
  //   Navigator.of(context as BuildContext).pushReplacement( MaterialPageRoute(builder:(ctx)=>LoginOrSignupPage()));
  // }

  // Future<void> checkUserLoggedIn() async{
  //   final _sharedprefs = await SharedPreferences.getInstance();
  //  final  _userLoggedIn=_sharedprefs.getBool(SAVE_KEY_NAME);
  // if(_userLoggedIn==null || _userLoggedIn==false){
  //   gotoLogin();
  // }
  // else{
  //   Navigator.of(context as BuildContext ).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage()));
  // }
  // }
}
