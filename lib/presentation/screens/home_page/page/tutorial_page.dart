import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TUTORIAL', style: text_theme_h()),
        centerTitle: true,
        backgroundColor: Color(0XFF9486F7),
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 750,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Theme(
                      data: ThemeData(
                        colorScheme: ColorScheme.light(
                          primary: Color(
                              0XFF9486F7), // Sets primary color for controls
                        ),
                      ),
                      child: Stepper(
                          currentStep: _currentStep,
                          onStepContinue: () {
                            if (_currentStep < 6) {
                              setState(() {
                                _currentStep += 1;
                              });
                            } else {
                              // Last step reached
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Tutorial completed')),
                              );
                              Navigator.of(context).pop();
                            }
                          },
                          onStepCancel: () {
                            if (_currentStep > 0) {
                              setState(() {
                                _currentStep -= 1;
                              });
                            }
                          },
                          steps: [
                            Step(
                              title: Icon(
                                Icons.handshake_rounded,
                                size: 40,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 0,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/Fc.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Welcome to BudgetBee!',
                                        style: text_theme_h()
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: Icon(
                                Icons.add_box_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 1,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/1c.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        '"Money magic awaits! Add transactions, unlock wonders!"',
                                        textAlign: TextAlign.center,
                                        style: text_theme()
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: Icon(
                                Icons.category,
                                size: 40,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 2,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/2c.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                        '"Play it your way! \n Stick to defaults or jazz it up by adding your own categories!"',
                                        textAlign: TextAlign.center,
                                        style: text_theme()
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: Icon(
                                Icons.dashboard_customize_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 3,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/3c.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        '"Search, sort, and filter like a boss! \nManage your transaction history hassle-free!"',
                                        textAlign: TextAlign.center,
                                        style: text_theme()
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: Icon(
                                Icons.notification_important_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 4,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/4c.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                        "Don't let brilliant ideas slip away! \n Tap into our reminders and never miss a beat!'",
                                        textAlign: TextAlign.center,
                                        style: text_theme()
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: Icon(
                                Icons.pie_chart_outline_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 5,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/5c.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    Text(
                                        'Visualize your money flow! \n Check out analytics now!',
                                        textAlign: TextAlign.center,
                                        style: text_theme()
                                            .copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ),
                            Step(
                              title: Icon(
                                Icons.done_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 6,
                              content: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "lib/assets/6c.jpg",
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Congratulations! \n You\'ve completed the tutorial!',
                                      textAlign: TextAlign.center,
                                      style:
                                          text_theme().copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    )))
          ],
        ),
      ),
    );
  }
}
