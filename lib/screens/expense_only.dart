import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/widgets/expense_tile.dart';
import 'package:flutter/material.dart';

class ExpenseOnly extends StatefulWidget {
  const ExpenseOnly({Key? key}) : super(key: key);

  @override
  _ExpenseOnlyState createState() => _ExpenseOnlyState();
}

class _ExpenseOnlyState extends State<ExpenseOnly> {
  List<Map<dynamic, dynamic>> expenses = [];

  @override
  void initState() {
    super.initState();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    DbHelper dbHelper = DbHelper();
    List<Map<dynamic, dynamic>> transactions =
        await dbHelper.fetchTransactions();
    List<Map<dynamic, dynamic>> expenseTransactions = transactions
        .where((transaction) => transaction['type'] == 'Expense')
        .toList();
    setState(() {
      expenses = expenseTransactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: expenses.map((transaction) {
            return ExpenseTile(
              value: transaction['amount'],
              note: transaction['note'],
              date: transaction['date'],
            );
          }).toList(),
        ),
      ),
    );
  }
}
