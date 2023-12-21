import 'package:hive/hive.dart';

part 'reminder_model.g.dart'; // Part file for Hive code generation

@HiveType(typeId: 2)
class Reminder extends HiveObject {
  @HiveField(0)
  late String note;

  @HiveField(1)
  late String time;

  @HiveField(2)
  late DateTime date;
}
