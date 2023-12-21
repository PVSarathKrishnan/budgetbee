import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:budgetbee/model/reminder_model.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  late TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime selectedDate = DateTime.now();
  late Timer _timer;
  TextEditingController noteController = TextEditingController();
  late Box<Reminder> remindersBox;
  List<Reminder> reminders = [];

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    remindersBox = await Hive.openBox<Reminder>('remindersBox');
    _getReminders();
  }

  Future<void> _openBox() async {
    remindersBox = await Hive.openBox<Reminder>('remindersBox');
    _getReminders();
  }

  Future<void> _getReminders() async {
    setState(() {
      reminders = remindersBox.values.toList();
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _setReminder() async {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (selectedDateTime.isAfter(now)) {
      final timeDifference = selectedDateTime.difference(now);
      _timer = Timer(timeDifference, () {
        _showNotification(noteController.text);
      });

      final reminder = Reminder()
        ..note = noteController.text
        ..time = selectedTime.format(context)
        ..date = selectedDate;

      await remindersBox.add(reminder);
      noteController.clear();

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a date and time in the future.'),
        ),
      );
    }
  }

  Future<void> _editReminder(int index) async {
    final reminder = remindersBox.getAt(index);

    selectedTime = TimeOfDay.fromDateTime(reminder?.date ?? DateTime.now());
    selectedDate = reminder?.date ?? DateTime.now();
    noteController.text = reminder?.note ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    labelStyle: text_theme(),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateFormat('MMM d, yyyy').format(selectedDate),
                        style: text_theme(),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    labelStyle: text_theme(),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${selectedTime.format(context)}',
                        style: text_theme(),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Enter Note for Reminder',
                  labelStyle: text_theme(),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: button_theme_2(),
                onPressed: () {
                  _updateReminder(index);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Update Reminder',
                  style: text_theme_h().copyWith(fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }

  void _updateReminder(int index) async {
    final now = DateTime.now();
    final selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (selectedDateTime.isAfter(now)) {
      final timeDifference = selectedDateTime.difference(now);
      _timer = Timer(timeDifference, () {
        _showNotification(noteController.text);
      });

      final updatedReminder = Reminder()
        ..note = noteController.text
        ..time = selectedTime.format(context)
        ..date = selectedDate;

      await remindersBox.putAt(index, updatedReminder);
      noteController.clear();

      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a date and time in the future.'),
        ),
      );
    }
  }

  Future<void> _deleteReminder(int index) async {
    await remindersBox.deleteAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _showNotification(String note) async {
    // Implement notification logic here
    // This is just a placeholder for showing notifications
    print('Reminder: $note');
  }

  Future<void> _addReminder(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    labelStyle: text_theme(),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        DateFormat('MMM d, yyyy').format(selectedDate),
                        style: text_theme(),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => _selectTime(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    labelStyle: text_theme(),
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${selectedTime.format(context)}',
                        style: text_theme(),
                      ),
                      const Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: noteController,
                decoration: InputDecoration(
                  labelText: 'Enter Note for Reminder',
                  labelStyle: text_theme(),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: button_theme_2(),
                onPressed: () {
                  Navigator.of(context).pop();
                  _setReminder();
                },
                child: Text(
                  'Set Reminder',
                  style: text_theme_h().copyWith(fontSize: 17),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF9486F7),
        title: Text(
          "REMINDER",
          style: text_theme_h(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your current Reminders',
              style: text_theme_h(),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<Reminder>>(
                valueListenable: remindersBox.listenable(),
                builder: (context, box, _) {
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final reminder = box.getAt(index);
                      return Card(
                        color: Color.fromARGB(66, 254, 244, 244),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(reminder?.note ?? ''),
                          titleTextStyle:
                              text_theme_h().copyWith(color: Colors.black),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time: ${reminder?.time ?? ''}',
                                style: text_theme(),
                              ),
                              Text(
                                'Date: ${DateFormat('yyyy MMM dd').format(reminder?.date ?? DateTime.now())}',
                                style: text_theme(),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Color(0XFF9486F7),
                                ),
                                onPressed: () {
                                  _editReminder(index);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: const Color.fromARGB(255, 255, 17, 0),
                                onPressed: () {
                                  _deleteReminder(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addReminder(context),
        tooltip: 'Add Reminder',
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF9486F7),
      ),
    );
  }
}
