import 'package:budgetbee/screens/add_transaction.dart';
import 'package:budgetbee/screens/add_name.dart';
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
    List<Map<dynamic, dynamic>> transactions = values.cast<Map<dynamic, dynamic>>();
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
}
