import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyDataPieChart extends StatelessWidget {
  const EmptyDataPieChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: Text(
              'Add expenses to see the pie chart.',
              style: text_theme_h().copyWith(color: Color(0XFF9486F7)),
            ),
          ),
          SizedBox(height: 10),
          Lottie.asset(
            "lib/assets/nodatachart.json",
            height: 100,
            width: 180,
          ),
        ],
      ),
    );
  }
}
