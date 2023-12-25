
import 'package:flutter/material.dart';

import '../style/text_button_theme.dart';

class cardIncome extends StatelessWidget {
  const cardIncome({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white60, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.arrow_upward,
            color: Colors.green,
          ),
          margin: EdgeInsets.only(right: 8),
        ),
        Column(
          children: [
            Text(
              "Income",
              style: text_theme_h(),
            ),
            Text(
              value,
              style: text_theme().copyWith(fontSize: 18),
            )
          ],
        )
      ],
    );
  }
}
