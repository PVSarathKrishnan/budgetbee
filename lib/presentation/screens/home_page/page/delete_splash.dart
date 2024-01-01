import 'package:budgetbee/presentation/screens/splash_screen/page/splash_screen.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class DeleteSplashScreen extends StatelessWidget {
  const DeleteSplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Navigates to AddNamePage after 4 seconds
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ),
        );
      });
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Deleting all your data...', style: text_theme_h()),
            SizedBox(height: 20),
            Lottie.asset("lib/assets/delete.json", height: 180, width: 180),
          ],
        ),
      ),
    );
  }
}
