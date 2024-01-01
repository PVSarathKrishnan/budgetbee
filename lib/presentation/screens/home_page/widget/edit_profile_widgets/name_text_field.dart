
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
        hintText: "Name",
        labelText: "Enter your name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        labelStyle: GoogleFonts.poppins(),
        floatingLabelStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(.7),
        contentPadding:
            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
      style: text_theme_h(),
    );
  }
}
