import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class nodata_widget extends StatelessWidget {
  const nodata_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No budget calculators yet.',
          style: text_theme_h().copyWith(color: Colors.black54),
        ),
        SizedBox(
          height: 20,
        ),
        Lottie.asset(
          "lib/assets/nodatachart.json",
          height: 100,
          width: 180,
        ),
      ],
    ));
  }
}
