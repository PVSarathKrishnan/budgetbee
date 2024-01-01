
import 'package:budgetbee/db/models/budget_calculator.dart';
import 'package:budgetbee/db/models/reminder_model.dart';
import 'package:budgetbee/presentation/screens/home_page/page/delete_splash.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WarningTextWidget extends StatelessWidget {
  const WarningTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Warning!',
          style: text_theme_h()
              .copyWith(color: const Color.fromARGB(255, 255, 17, 0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to erase all data?',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: text_theme().color),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'This action will delete all the data permanently!',
            style: text_theme_p().copyWith(
                fontSize: 15, color: Color.fromARGB(255, 111, 111, 111)),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            // Clearing Hive boxes
            await Hive.box('money').clear();
            await Hive.box('categories').clear();
            await Hive.box("expenseCategoryBox").clear();
            await Hive.box("incomeCategoryBox").clear();
            await Hive.box<BudgetCalculator>('budget_calculators').clear();
            await Hive.box('budgetCalculatorBox').clear();
            await Hive.box<Reminder>('remindersbox').clear();

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
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: text_theme_h().copyWith(color: Color(0XFF9486F7)),
          ),
        ),
      ],
    );
  }
}
