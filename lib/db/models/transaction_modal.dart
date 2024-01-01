
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class TransactionModal {

  @HiveField(0)
  final int amount;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String note;

  @HiveField(3)
  final String type;

  TransactionModal(this.amount, this.date, this.note, this.type);
  fetch() {}
}
