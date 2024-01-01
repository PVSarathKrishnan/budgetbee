import 'package:budgetbee/db/models/budget_calculator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BudgetCalculatorFunctions {
  final String _boxName = 'budget_calculators'; // Hive box name for BudgetCalculator

  Future<List<BudgetCalculator>> fetchBudgetCalculators() async {
    try {
      var box = await Hive.openBox<BudgetCalculator>(_boxName);
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to fetch budget calculators: $e');
    }
  }

  Future<void> addBudgetCalculator(BudgetCalculator calculator) async {
    try {
      var box = await Hive.openBox<BudgetCalculator>(_boxName);
      await box.add(calculator);
    } catch (e) {
      throw Exception('Failed to add budget calculator: $e');
    }
  }

  Future<void> updateBudgetCalculator(BudgetCalculator calculator) async {
    try {
      var box = await Hive.openBox<BudgetCalculator>(_boxName);
      await box.put(calculator.key, calculator);
    } catch (e) {
      throw Exception('Failed to update budget calculator: $e');
    }
  }

  Future<void> deleteBudgetCalculator(int index) async {
    try {
      var box = await Hive.openBox<BudgetCalculator>(_boxName);
      await box.deleteAt(index);
    } catch (e) {
      throw Exception('Failed to delete budget calculator: $e');
    }
  }

  // Additional methods for specific operations as needed

  // Remember to close the box after usage
  Future<void> closeBox() async {
    await Hive.close();
  }
}
