
import 'package:budgetbee/style/text_theme.dart';
import 'package:budgetbee/widgets/reset_data_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class show_warning extends StatelessWidget {
  const show_warning({
    super.key,
    required this.box,
    required this.context,
  });

  final Box box;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Change the background color here
      title: Text('Warning!',
          style: text_theme_h().copyWith(
              color: const Color.fromARGB(
                  255, 255, 17, 0))), // Set the text style for the title
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to erase all data?',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    text_theme().color), // Set the text style for the content
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'This action will delete all the data permanently!',
            style: text_theme_p().copyWith(
                fontSize: 15,
                color: Color.fromARGB(
                    255, 111, 111, 111)), // Set the text style for the content
          ),
        ],
      ),
      actions: <Widget>[
        reset_data_button(box: box),
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
