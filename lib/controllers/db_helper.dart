
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
}