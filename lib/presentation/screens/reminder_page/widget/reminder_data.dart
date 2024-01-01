
import 'package:budgetbee/db/models/reminder_model.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderDataWidget extends StatelessWidget {
  const ReminderDataWidget({
    super.key,
    required this.reminder,
  });

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Time: ${reminder.time}',
          style: text_theme(),
        ),
        Text(
          'Date: ${DateFormat('yyyy MMM dd').format(reminder.date)}',
          style: text_theme(),
        ),
      ],
    );
  }
}
