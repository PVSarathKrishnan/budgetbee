import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ReminderNotification extends StatefulWidget {
  @override
  _ReminderNotificationState createState() => _ReminderNotificationState();
}

class _ReminderNotificationState extends State<ReminderNotification> {
  late Timer _timer;
  late List<TimeOfDay> reminderTimes = []; // List of reminder times from Hive

  @override
  void initState() {
    super.initState();
    _initHive();
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      checkReminderTime();
    });
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    final box = await Hive.openBox('remindersBox');
    setState(() {
      reminderTimes = (box.get('reminders') ?? []).cast<TimeOfDay>();
    });
  }

  void checkReminderTime() {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);

    for (var i = 0; i < reminderTimes.length; i++) {
      if (currentTime == reminderTimes[i]) {
        // Get reminder notes from Hive at the same index as the reminder time
        final box = Hive.box('remindersBox');
        final notes = box.get('notes') ?? <String>[];
        final reminderNote = notes.length > i ? notes[i] : '';

        // Display reminder note in a dialog
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Reminder'),
                content: Text('Note: $reminderNote'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        });
        break;
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder Notification'),
      ),
      body: Center(
        child: Text(
          'Listening for reminders...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('remindersBox');

  runApp(MaterialApp(
    home: ReminderNotification(),
  ));
}
