import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/screens/add_transaction.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';

class IncomeTile extends StatelessWidget {
  const IncomeTile({
    Key? key,
    required this.value,
    required this.note,
    required this.date,
  }) : super(key: key);

  final int value;
  final String note;
  final DateTime date;

  static const int maxCharactersToShow = 10;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(value.toString()), // Specify a unique key for each Slidable
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showWarning(context); // Show the warning dialog
                },
              );
            },
            backgroundColor: Color.fromARGB(255, 255, 0, 0),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              // Edit thetransaction.
            },
            backgroundColor: Color.fromARGB(255, 0, 115, 255),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            icon: Icons.edit_document,
            label: 'Edit',
          ),
        ],
      ),
      child: GestureDetector(
        onDoubleTap: () {
          _showCustomBottomSheet(context);
        },
        child: Container(
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${date.day}/${DateFormat('MMM').format(selectedDate)}/${date.year}",
                        style: text_theme_h(),
                      ),
                      SizedBox(
                        width: 200,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "${note}",
                            style: text_theme(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "+ ₹$value",
                    style: text_theme_color_size(Colors.green, 22),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.4),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Income Details",
                style: text_theme_color(Colors.white),
              ),
              SizedBox(height: 25),
              _buildPlaceholder(Icons.currency_rupee_outlined, 'Amount', value),
              SizedBox(height: 20),
              _buildPlaceholder(Icons.description, 'Description', note),
              SizedBox(height: 20),
              _buildPlaceholder(
                  Icons.calendar_today,
                  '${date.day}/${DateFormat('MMMM').format(selectedDate)}/${date.year}',
                  null),
              SizedBox(height: 20),
              _buildPlaceholder(Icons.access_time,
                  '${date.hour}:${date.minute}:${date.second}', null),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildPlaceholder(IconData icon, String title, dynamic value) {
  final String displayedText = value != null ? '$value' : title;

  return GlassContainer(
    width: 300,
    height: 60,
    borderRadius: BorderRadius.circular(16),
    blur: 5,
    border: Border.all(width: 1, color: Colors.grey.shade300),
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Expanded(
              child: displayedText.length > 22
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        displayedText,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : Text(
                      displayedText,
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    ),
  );
}

AlertDialog showWarning(BuildContext context) {
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
          'Are you sure you want to erase this transaction?',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: text_theme().color), // Set the text style for the content
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'This action will delete the data permanently!',
          style: text_theme_p().copyWith(
              fontSize: 15,
              color: Color.fromARGB(
                  255, 111, 111, 111)), // Set the text style for the content
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () async {
          // Deletion of transaction
        },

        child: Text(
          'Delete ',
          style: text_theme_h().copyWith(color: Color.fromARGB(255, 255, 0, 0)),
        ), // Set the text style for the action
      ),
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
