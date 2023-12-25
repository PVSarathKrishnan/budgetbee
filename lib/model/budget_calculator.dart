import 'package:hive/hive.dart';

part 'budget_calculator.g.dart';

@HiveType(typeId: 4)
class BudgetCalculator extends HiveObject {
  @HiveField(0)
  late String category;

  @HiveField(1)
  late double amountLimit; // Changed the type to double

  @HiveField(2)
  late double usedAmount; // Changed the type to double

  BudgetCalculator({
    required this.category,
    required this.amountLimit,
    this.usedAmount = 0,
  });
}
