import 'package:hive/hive.dart';
part 'addtransactionmodel.g.dart';

@HiveType(typeId: 2)
class AddTransactionModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? amount;

  @HiveField(2)
  String? description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  bool? type;

  @HiveField(5)
  int? total = 5;

  AddTransactionModel(
      {required this.amount,
      required this.description,
      required this.date,
      required this.id,
      required this.type,
      required this.total});
}
