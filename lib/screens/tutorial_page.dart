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
        title: Text('Tutorial', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0XFF9486F7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Stepper(
                  currentStep: _currentStep,
                  onStepContinue: () {
                    if (_currentStep < 2) {
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
                      title: Text('Step 1'),
                      isActive: _currentStep >= 0,
                      content: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text('Welcome to BudgetBee'),
                      ),
                    ),
                    Step(
                      title: Text('Step 2'),
                      isActive: _currentStep >= 1,
                      content: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text('Tutorial 2'),
                      ),
                    ),
                    Step(
                      title: Text('Step 3'),
                      isActive: _currentStep >= 2,
                      content: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text('Tutorial 3'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
