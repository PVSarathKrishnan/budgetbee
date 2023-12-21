import 'package:budgetbee/screens/welcome_screen.dart';
import 'package:budgetbee/style/text_theme.dart';
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
              buildPage("lib/assets/1c.jpg", "Home Page"),
              buildPage("lib/assets/2c.jpg", "Add Transaction Page"),
              buildPage("lib/assets/3c.jpg", "Transaction History Page"),
              buildPage("lib/assets/4c.jpg", "Master your money. Good luck"),
            ],
          ),
          Positioned(
            top: 60, // Adjust the positioning as needed
            left: 160, // Adjust the positioning as needed
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Page ${_currentPage + 1}/4', // Display the current page number
                style: text_theme_h1(),
              ),
            ]),
          ),
          Positioned(
            top: 120,
            right: 20,
            child: TextButton(
              style: button_theme().copyWith(
                  backgroundColor: MaterialStatePropertyAll(Color(0XFF9486F7))),
              onPressed: () {
                _pageController.jumpToPage(3); // Skip to the last page
              },
              child: Text(
                'Skip',
                style: text_theme_h().copyWith(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_currentPage >
                    0) // Show previous button if not on the first page
                  ElevatedButton(
                    style: button_theme_1().copyWith(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0XFF9486F7))),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      '  Previous  ',
                      style: text_theme_h(),
                    ),
                  ),
                const SizedBox(width: 26),
                ElevatedButton(
                  style: button_theme().copyWith(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0XFF9486F7))),
                  onPressed: () {
                    if (_currentPage < 3) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      // Navigate to the next screen when on the last page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeScreen()),
                      );
                    }
                  },
                  child: Text(
                    _currentPage < 3 ? 'Continue' : 'Finish',
                    style: text_theme_h(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String imagePath, String content) {
    return Center(
      child: Container(
        width: 380,
        height: 480,
        decoration: BoxDecoration(
          color: Color(0XFF9486F7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 15,
              blurStyle: BlurStyle.outer,
              spreadRadius: .2,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              content,
              style: text_theme_h(),
            ),
          ],
        ),
      ),
    );
  }
}
