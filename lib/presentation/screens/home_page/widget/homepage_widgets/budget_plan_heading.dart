

import 'package:budgetbee/presentation/screens/budget_calculator_page/page/budget_calculator_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class BudgetHeading extends StatelessWidget {
  const BudgetHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Your Budget Plans",
            style: text_theme_h(),
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
                    builder: (context) =>
                        BudgetCalculatorPage(),
                  ));
                },
                icon: Icon(
                  Icons.navigate_next_sharp,
                  size: 30,
                ),
                tooltip: "explore budget planing",
              ),
            ),
          )
        ],
      ),
    );
  }
}
