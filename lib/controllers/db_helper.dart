import 'package:budgetbee/db/budget_calculator_functions.dart';
import 'package:budgetbee/model/budget_calculator.dart';
import 'package:budgetbee/model/transaction_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbHelper {
  late Box box;
  late SharedPreferences preferences;

  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box("money");
  }

  Future addData(int amount, DateTime date, String note, String type) async {
    var value = {"amount": amount, "date": date, "type": type, "note": note};
    box.add(value);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      // return an empty map
      return Future.value({});
    } else {
      //return the data in the box as a map
      return Future.value(box.toMap());
    }
  }

  Future<List<Map<dynamic, dynamic>>> fetchTransactions() async {
    if (box.isEmpty) {
      return []; // Return an empty list if no data is available
    } else {
      List<dynamic> values = box.values.toList();
      List<Map<dynamic, dynamic>> transactions =
          values.cast<Map<dynamic, dynamic>>();
      return transactions;
    }
  }

  Future<void> resetAllData() async {
    await box.clear(); // Clears all data in the box
  }

  addName(String name) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name);
  }

  getName() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString("name");
  }

  Future<List<TransactionModal>> fetchTransactionData() async {
    if (box.isEmpty) {
      return []; // Return an empty list if no data is available
    } else {
      List<TransactionModal> transactions = [];

      box.toMap().values.forEach((element) {
        transactions.add(TransactionModal(element["amount"] as int,
            element["date"] as DateTime, element["note"], element["type"]));
      });
      return transactions;
    }
  }

  Future<Map<String, double>> fetchExpenseNoteAmountMap() async {
    if (box.isEmpty) {
      return {}; // Return an empty map if no data is available
    } else {
      Map<String, double> expenseNoteAmountMap = {};

      box.toMap().forEach((key, value) {
        final type = value["type"] as String;
        final note = value["note"] as String;
        final amount = value["amount"] as int;

        if (type == "Expense") {
          if (expenseNoteAmountMap.containsKey(note)) {
            expenseNoteAmountMap[note] = expenseNoteAmountMap[note]! + amount;
          } else {
            expenseNoteAmountMap[note] = amount.toDouble();
          }
        }
      });

      return expenseNoteAmountMap;
    }
  }

  Future<Map<String, double>> fetchIncomeNoteAmountMap() async {
    if (box.isEmpty) {
      return {}; // Return an empty map if no data is available
    } else {
      Map<String, double> IncomeNoteAmountMap = {};

      box.toMap().forEach((key, value) {
        final type = value["type"] as String;
        final note = value["note"] as String;
        final amount = value["amount"] as int;

        if (type == "Income") {
          if (IncomeNoteAmountMap.containsKey(note)) {
            IncomeNoteAmountMap[note] = IncomeNoteAmountMap[note]! + amount;
          } else {
            IncomeNoteAmountMap[note] = amount.toDouble();
          }
        }
      });

      return IncomeNoteAmountMap;
    }
  }

  Future<void> updateBudgetCalculator(String category, int amount) async {
    BudgetCalculatorFunctions budgetCalculatorFunctions =
        BudgetCalculatorFunctions();
    // ignore: unused_local_variable
    DbHelper dbHelper = DbHelper();

    // Fetch all budget calculators
    List<BudgetCalculator> budgetCalculators =
        await budgetCalculatorFunctions.fetchBudgetCalculators();

    // Find the budget calculator with the matching category
    BudgetCalculator? matchingCalculator;
    for (var calculator in budgetCalculators) {
      if (calculator.category == category) {
        matchingCalculator = calculator;
        break;
      }
    }

    // Update the budget calculator amount if a match is found
    if (matchingCalculator != null) {
      matchingCalculator.amountLimit -= amount.toDouble(); // Adjust the amount

      // Update the existing budget calculator in the database
      await budgetCalculatorFunctions
          .updateBudgetCalculator(matchingCalculator);

      // Optionally, you can also update the Hive box directly
      // await dbHelper.updateBudgetCalculatorInBox(matchingCalculator);
    }
  }

  Future<void> deleteTransaction(int amount, DateTime date, String note) async {
    try {
      // Fetch all transactions
      List<Map<dynamic, dynamic>> transactions = await fetchTransactions();

      // Find the transaction that matches the provided details
      var transactionToDelete = transactions.firstWhere(
        (transaction) =>
            transaction['amount'] == amount &&
            transaction['date'] == date &&
            transaction['note'] == note,
      );

      if (transactionToDelete != null) {
        // Remove the transaction from the database
        await box.deleteAt(box.values.toList().indexOf(transactionToDelete));
      } else {
        // Handle case where the transaction to delete was not found
      }
    } catch (e) {
      // Handle deletion errors here
    }
  }

  Future<void> updateTransaction(int oldAmount, DateTime oldDate,
      String oldNote, int newAmount, DateTime newDate, String newNote) async {
    try {
      // Fetch all transactions
      List<Map<dynamic, dynamic>> transactions = await fetchTransactions();

      // Find the transaction that matches the provided details
      var transactionToUpdate = transactions.firstWhere(
        (transaction) =>
            transaction['amount'] == oldAmount &&
            transaction['date'] == oldDate &&
            transaction['note'] == oldNote,
      );

      if (transactionToUpdate != null) {
        // Update the transaction details
        int transactionIndex = box.values.toList().indexOf(transactionToUpdate);
        Map updatedTransaction = {
          'amount': newAmount,
          'date': newDate,
          'type': transactionToUpdate['type'],
          'note': newNote,
        };

        // Update the transaction in the box
        await box.putAt(transactionIndex, updatedTransaction);
        print('Transaction updated successfully');
      } else {
        print('Transaction not found');
        // Handle case where the transaction to update was not found
      }
    } catch (e) {
      print('Error updating transaction: $e');
      // Handle update errors here
    }
  }
}
