
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class NoteFieldWidget extends StatelessWidget {
  const NoteFieldWidget({
    super.key,
    required this.noteController,
  });

  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: noteController,
      decoration: InputDecoration(
        labelText: 'Enter Note for Reminder',
        labelStyle: text_theme(),
        border: OutlineInputBorder(),
      ),
    );
  }
}
