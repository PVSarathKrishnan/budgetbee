
import 'package:budgetbee/presentation/screens/statistics_page/page/statistics_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseHeading extends StatelessWidget {
  const ExpenseHeading({
    super.key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  final int totalBalance;
  final int totalIncome;
  final int totalExpense;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Expense Tracker - ${DateFormat('MMMM').format(DateTime.now())}",
            style: text_theme_h(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: Color(0XFF9486F7),
                borderRadius: BorderRadius.circular(60)),
            child: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => StatPage(
                    totalBalance: totalBalance,
                    totalIncome: totalIncome,
                    totalExpense: totalExpense,
                  ),
                ));
              },
              icon: Icon(
                Icons.navigate_next_sharp,
                size: 30,
              ),
              tooltip: "Explore more Statistics",
            ),
          ),
        )
      ],
    );
  }
}
