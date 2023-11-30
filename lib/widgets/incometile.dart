import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class incomeTile extends StatelessWidget {
  const incomeTile({
    super.key,
    required this.value,
    required this.note,
    required this.date,
  });

  final int value;
  final String note;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 30,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${date.day}/${date.month}/${date.year} ",
                          style: text_theme(),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "${note}",
                  style: text_theme(),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "+$value",
                  style: text_theme_color(Colors.green),
                ),
              ],
            )
          ],
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
            color:Colors.white.withOpacity(.4),
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
              _buildPlaceholder(Icons.attach_money, 'Amount', value),
              SizedBox(height: 20),
              _buildPlaceholder(Icons.description, 'Description', note),
              SizedBox(height: 20),
              _buildPlaceholder(Icons.calendar_today,
                  '${date.year}/${date.month}/${date.day}', null),
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

  Widget _buildPlaceholder(IconData icon, String title, dynamic value) {
    return GlassContainer(
      width: 300,
      height: 60,
      borderRadius: BorderRadius.circular(16),
      blur: 5,
      border: Border.all(width: 1, color: Colors.grey.shade300),
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
            Text(
              value != null ? '$value' : title,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
