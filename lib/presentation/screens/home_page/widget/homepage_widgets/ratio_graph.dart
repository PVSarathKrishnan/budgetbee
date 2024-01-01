
import 'package:budgetbee/presentation/common_widgets/expense_income_widget.dart';
import 'package:flutter/material.dart';

class RatioGraphWidget extends StatelessWidget {
  const RatioGraphWidget({
    super.key,
    required this.expenseToIncomeRatio,
  });

  final double expenseToIncomeRatio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 420,
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.4),
                spreadRadius: 5,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
              child: ExpenseIncomeRatioWidget(
                  expenseToIncomeRatio:
                      expenseToIncomeRatio)),
        ),
      ],
    );
  }
}
