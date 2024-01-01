
import 'package:budgetbee/presentation/common_widgets/expense_card.dart';
import 'package:budgetbee/presentation/common_widgets/income_card.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
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
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 162, 151, 248),
            Color.fromARGB(255, 164, 152, 250),
            Color.fromARGB(255, 150, 137, 253),
            Color.fromARGB(255, 164, 152, 250),
            Color.fromARGB(255, 162, 151, 248),
          ])),
      padding: EdgeInsets.all(12),
      child: Column(children: [
        Text(
          "Available Balance",
          style: text_theme_h(),
        ),
        Text(
          "₹ ${totalBalance}",
          style: text_theme_h(),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              cardIncome(value: "₹ ${totalIncome}"),
              SizedBox(
                width: 50,
              ),
              cardEpense(value: "₹ ${totalExpense}")
            ],
          ),
        ),
      ]),
    );
  }
}
