import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle text_theme() {
  return GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500);
}

TextStyle text_theme_color(Color value) {
  return GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.bold, color: value);
}

TextStyle text_theme_color_size(Color value, double size) {
  return GoogleFonts.poppins(
      fontSize: size, fontWeight: FontWeight.bold, color: value);
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

TextStyle text_theme_hyper_golden() {
  return GoogleFonts.poppins(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    foreground: Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFFFD700),
          Colors.white,
          Color(0xFFFFD700),
          Colors.white,
          Color(0xFFFFD700),
          Colors.white,
          Colors.white,
          Color(0xFFFFD700),
        ],
        stops: [0, 0.2, 0.4, .5, 0.6, 0.8, .9, 1],
      ).createShader(Rect.fromLTWH(
          0.0, 0.0, 200.0, 70.0)), // Adjust the Rect dimensions as needed
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
    mouseCursor: MaterialStateMouseCursor.textable,
    backgroundColor: MaterialStateProperty.all(Color(0xff04CE9A)),
    elevation: MaterialStateProperty.all(10), // Example elevation value

    // Shadow
    // shadowColor: MaterialStateProperty.all(Colors.deepPurple.withOpacity(.2)),
    overlayColor: MaterialStateProperty.all(
        Color(0XFF9486F7)), // Adjust overlay color when pressed

    // Padding
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 8.0), // Reducing horizontal padding
    ),

    // Text Style
    textStyle: MaterialStateProperty.all(text_theme()),

    // Shape
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0), // Adjust border radius
        side: BorderSide(
            color: const Color.fromARGB(
                255, 255, 255, 255), // Deep purple border color
            width: 2, // Border thickness
            strokeAlign: 2),
      ),
    ),

    // Set a minimum size to adjust the button width
    minimumSize:
        MaterialStateProperty.all(Size(100, 40)), // Example width and height
  );
}

ButtonStyle button_theme_1() {
  return ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.zero),
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.grey.withOpacity(0.8);
        }
        if (states.contains(MaterialState.pressed)) {
          return Color.fromARGB(255, 255, 255, 255);
        }
        return Color.fromARGB(0, 255, 1, 1);
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: Color(0xFF9486F7), width: 1.5),
      ),
    ),
  );
}

ButtonStyle button_theme_2() {
  return ButtonStyle(
    mouseCursor: MaterialStateMouseCursor.textable,
    backgroundColor: MaterialStateProperty.all(Color(0XFF9486F7)),
    elevation: MaterialStateProperty.all(10), // Example elevation value

    // Shadow
    // shadowColor: MaterialStateProperty.all(Colors.deepPurple.withOpacity(.2)),
    overlayColor: MaterialStateProperty.all(
        Color(0xff04CE9A)), // Adjust overlay color when pressed

    // Padding
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
          vertical: 6.0, horizontal: 6.0), // Reducing horizontal padding
    ),

    // Text Style
    textStyle: MaterialStateProperty.all(text_theme()),

    // Shape
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Adjust border radius
        side: BorderSide(
            color: const Color.fromARGB(
                255, 255, 255, 255), // Deep purple border color
            width: .5, // Border thickness
            strokeAlign: .5),
      ),
    ),

    // Set a minimum size to adjust the button width
    minimumSize:
        MaterialStateProperty.all(Size(100, 40)), // Example width and height
  );
}
