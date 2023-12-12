// import 'package:budgetbee/model/addtransactionmodel.dart';
// import 'package:budgetbee/model/usermodel.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// ValueNotifier<List<AddTransactionModel>> transactionListNotifier = ValueNotifier([]);

// Future<void> addTransaction(AddTransactionModel value) async {
//   final transactionBox = await Hive.openBox<AddTransactionModel>("transaction_db");
//   final id = await transactionBox.add(value);
//   final data = transactionBox.get(id);
//   await transactionBox.put(
//       id,
//       AddTransactionModel(
//         amount: data!.amount, 
//         description: data.description,
//         date: data.date, 
//         id: id, 
//         type: data.type, 
//         total: data.total)
//      );
// }
