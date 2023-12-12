import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/widgets/incometile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeOnly extends StatefulWidget {
  const IncomeOnly({super.key});

  @override
  State<IncomeOnly> createState() => _IncomeOnlyState();
}

class _IncomeOnlyState extends State<IncomeOnly> {
  List<Map<dynamic, dynamic>> incomes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchIncomes();
  }

  Future<void> fetchIncomes() async {
    DbHelper dbHelper = DbHelper();
    List<Map<dynamic, dynamic>> transactions =
        await dbHelper.fetchTransactions();
    List<Map<dynamic, dynamic>> incomeTransactions = transactions
        .where((transaction) => transaction['type'] == 'Income')
        .toList();
    setState(() {
      incomes = incomeTransactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: incomes.map((transaction) {
          return IncomeTile(
              value: transaction['amount'],
              note: transaction['note'],
              date: transaction['date']);
        }).toList()),
      ),
    );
  }
}
