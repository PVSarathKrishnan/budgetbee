import 'package:hive/hive.dart';

part 'budget_calculator.g.dart';

@HiveType(typeId: 4)
class BudgetCalculator extends HiveObject {
  @HiveField(0)
  late String category;

  @HiveField(1)
  late double amountLimit;

  BudgetCalculator({required this.category, required this.amountLimit});
}
