import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/screens/add_name.dart';
import 'package:budgetbee/screens/welcome_screen.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DbHelper dbHelper = DbHelper();

  Future<void> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');

    if (name != null && name.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddName(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('lib/assets/Logo.png')),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Budget Better, Together",
                style: text_theme_p(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
