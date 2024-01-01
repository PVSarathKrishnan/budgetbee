import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/presentation/screens/add_name/page/add_name.dart';
import 'package:budgetbee/presentation/screens/splash_screen/page/welcome_screen.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
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
              Column(
                children: [
                  Text(
                    "BudgetBee",
                    style: text_theme_hyper(),),
                  Text(
                    "Budget Better, Together",
                    style: text_theme_p(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
