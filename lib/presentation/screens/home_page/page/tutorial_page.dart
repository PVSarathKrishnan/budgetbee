import 'package:budgetbee/presentation/screens/home_page/widget/tutorial_widgets/content_widget.dart';
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
                              content: FirstContent(),
                            ),
                            Step(
                              title: Icon(
                                Icons.add_box_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 1,
                              content: SecondContent(),
                            ),
                            Step(
                              title: Icon(
                                Icons.category,
                                size: 40,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 2,
                              content: ThirdContent(),
                            ),
                            Step(
                              title: Icon(
                                Icons.dashboard_customize_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 3,
                              content: FourthContent(),
                            ),
                            Step(
                              title: Icon(
                                Icons.notification_important_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 4,
                              content: FifthContent(),
                            ),
                            Step(
                              title: Icon(
                                Icons.pie_chart_outline_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 5,
                              content: SixthContent(),
                            ),
                            Step(
                              title: Icon(
                                Icons.done_rounded,
                                size: 45,
                                color: Color(0XFF9486F7),
                              ),
                              isActive: _currentStep >= 6,
                              content: SeventhContent(),
                            ),
                          ]),
                    )))
          ],
        ),
      ),
    );
  }
}
