import 'package:budgetbee/db/models/reminder_model.dart';
import 'package:hive/hive.dart';


Future<void> addReminder(Reminder reminder) async {
  final box = await Hive.openBox<Reminder>('remindersBox');
  await box.add(reminder);
}

Future<void> editReminder(int index, Reminder newReminder) async {
  final box = await Hive.openBox<Reminder>('remindersBox');
  await box.putAt(index, newReminder);
}

Future<void> deleteReminder(int index) async {
  final box = await Hive.openBox<Reminder>('remindersBox');
  await box.deleteAt(index);
}
