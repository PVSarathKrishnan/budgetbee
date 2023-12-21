
import 'package:budgetbee/screens/deletesplash.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class reset_data_button extends StatelessWidget {
  const reset_data_button({
    super.key,
    required this.box,
  });

  final Box box;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // Clearing Hive boxes
        await box.clear();

        // Clearing shared preferences
        SharedPreferences preferences =
            await SharedPreferences.getInstance();
        await preferences.clear();

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => DeleteSplashScreen(),
        ));
      },

      child: Text(
        'Delete ',
        style:
            text_theme_h().copyWith(color: Color.fromARGB(255, 255, 0, 0)),
      ), // Set the text style for the action
    );
  }
}
