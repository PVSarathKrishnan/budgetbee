
import 'package:flutter/material.dart';

class skip_button extends StatelessWidget {
  const skip_button({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height *
          0.12, // Adjust according to your layout
      right: 20,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0XFF9486F7)),
        ),
        onPressed: () {
          _pageController.jumpToPage(3); // Skip to the last page
        },
        child: Text(
          'Skip',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
