import 'package:budgetbee/model/budget_calculator.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class BudgetFunctions {
  late Box<BudgetCalculator> budgetCalculatorBox;

  Future<void> initBudget() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(BudgetCalculatorAdapter());
    budgetCalculatorBox = await Hive.openBox<BudgetCalculator>('budget_calculators');
  }

  Future<void> addBudgetCalculator(String category, double amountLimit) async {
    final newBudgetCalculator = BudgetCalculator(category: category, amountLimit: amountLimit);
    await budgetCalculatorBox.add(newBudgetCalculator);
  }

  Future<List<BudgetCalculator>> getAllBudgetCalculators() async {
    final List<BudgetCalculator> allBudgetCalculators = budgetCalculatorBox.values.toList();
    return allBudgetCalculators;
  }
}
