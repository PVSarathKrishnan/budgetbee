import 'package:budgetbee/presentation/screens/carousel_page/widget/continue_button.dart';
import 'package:budgetbee/presentation/screens/carousel_page/widget/image_view.dart';
import 'package:budgetbee/presentation/screens/carousel_page/widget/skip_button.dart';
import 'package:budgetbee/presentation/screens/splash_screen/page/welcome_screen.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class CarouselPage extends StatefulWidget {
  const CarouselPage({Key? key}) : super(key: key);

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            image_view(imagePath: "lib/assets/1c.jpg", content: "Home Page"),
            image_view(imagePath: "lib/assets/2c.jpg", content: "Add Transaction Page"),
            image_view(imagePath: "lib/assets/3c.jpg", content: "Transaction History Page"),
            image_view(imagePath: "lib/assets/6c.jpg", content: "Master your money. Good luck"),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.06, // Adjust according to your layout
          left: 20,
          child: Row(
            children: [
              Text(
                'Page ${_currentPage + 1}/4', // Display the current page number
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        skip_button(pageController: _pageController),
        continue_button(currentPage: _currentPage, pageController: _pageController),
      ],
    ));
  }
}
