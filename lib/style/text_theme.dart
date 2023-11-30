import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle text_theme() {
  return GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold);
}
TextStyle text_theme_color(Color value) {
  return GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: value);
}

TextStyle text_theme_h() {
  return GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

TextStyle text_theme_hyper() {
  return GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );
}


TextStyle text_theme_h1() {
  return GoogleFonts.robotoMono(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 3,
  );
}

TextStyle text_theme_p() {
  return GoogleFonts.quicksand(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}

ButtonStyle button_theme() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0XFF9486F7)),
    elevation: MaterialStateProperty.all(7), // Example elevation value

    // Shadow
    shadowColor: MaterialStateProperty.all(Colors.black),
    overlayColor: MaterialStateProperty.all(
        Colors.grey), // Adjust overlay color when pressed

    // Padding
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 8.0), // Reducing horizontal padding
    ),

    // Text Style
    textStyle: MaterialStateProperty.all(
      TextStyle(
        color: Colors.white, // Text color
        fontSize: 16.0, // Text size
        fontWeight: FontWeight.bold, // Text weight
      ),
    ),

    // Shape
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust border radius
      ),
    ),

    // Set a minimum size to adjust the button width
    minimumSize:
        MaterialStateProperty.all(Size(100, 40)), // Example width and height
  );
}
