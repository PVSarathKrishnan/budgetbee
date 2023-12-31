import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class cardEpense extends StatelessWidget {
  const cardEpense({
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
            Icons.arrow_downward,
            color: Colors.red,
          ),
          margin: EdgeInsets.only(right: 8),
        ),
        Column(
          children: [
            Text(
              "Expense",
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
