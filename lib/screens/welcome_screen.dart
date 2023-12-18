import 'package:budgetbee/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late SharedPreferences preferences;

  Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<SharedPreferences>(
        future: getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child:
                    CircularProgressIndicator(), // Show a loading indicator while waiting for SharedPreferences
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            preferences = snapshot.data!;
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
                      SizedBox(height: 200),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Container(
                              height: 200,
                              width: 200,
                              child:
                                  Image(image: AssetImage('lib/assets/Logo.png')),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      Container(
                        width: 280,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Hello ${preferences.getString('name')}',
                              style: GoogleFonts.dancingScript(
                                fontSize: 33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child: Column(
                                children: [
                                  Lottie.asset(
                                    'lib/assets/Loading.json',
                                    height: 100,
                                    width: 180,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
