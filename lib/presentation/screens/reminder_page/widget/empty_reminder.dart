
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyReminderWidget extends StatelessWidget {
  const EmptyReminderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No reminders right now',
              style: text_theme_h().copyWith(color: Colors.black45),
            ),
            SizedBox(
              height: 20,
            ),
            Lottie.asset("lib/assets/reminder.json",
                height: 100, width: 180)
          ],
        ),
      );
  }
}
