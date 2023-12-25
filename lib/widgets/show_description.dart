
import 'package:budgetbee/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class show_description extends StatelessWidget {
  const show_description({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Change the background color here
      title: Text('Chart Information',
          style: text_theme_h()), // Set the text style for the title
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horizontal Axis: Date',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    text_theme().color), // Set the text style for the content
          ),
          Text(
            'Represents the dates in the chart.',
            style: text_theme_p().copyWith(
                color: Color(0XFF9486F7)), // Set the text style for the content
          ),
          SizedBox(height: 10),
          Text(
            'Vertical Axis: Amount',
            style: text_theme(), // Set the text style for the content
          ),
          Text(
            'Denotes the amount of transaction',
            style: text_theme_p().copyWith(
                color: Color(0XFF9486F7)), // Set the text style for the content
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: text_theme_h().copyWith(color: Color(0XFF9486F7)),
          ), // Set the text style for the action
        ),
      ],
    );
  }
}
