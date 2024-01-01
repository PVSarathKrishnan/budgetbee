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
            buildPage("lib/assets/1c.jpg", "Home Page"),
            buildPage("lib/assets/2c.jpg", "Add Transaction Page"),
            buildPage("lib/assets/3c.jpg", "Transaction History Page"),
            buildPage("lib/assets/6c.jpg", "Master your money. Good luck"),
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
        Positioned(
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
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height *
              0.12, 
          right: MediaQuery.of(context).size.width *
              0.05,
          left:  MediaQuery.of(context).size.width *
              0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage > 0)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0XFF9486F7)),
                  ),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                  child: Text('Previous'),
                ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0XFF9486F7)),
                ),
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
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  }
                },
                child: Text(_currentPage < 3 ? 'Continue' : 'Finish'),
              ),
            ],
          ),
        ),
      ],
    ));
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
