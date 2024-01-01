import 'package:budgetbee/presentation/screens/budget_calculator_page/page/budget_calculator_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExpenseIncomeRatioWidget extends StatefulWidget {
  final double expenseToIncomeRatio;

  const ExpenseIncomeRatioWidget({
    Key? key,
    required this.expenseToIncomeRatio,
  }) : super(key: key);

  @override
  _ExpenseIncomeRatioWidgetState createState() =>
      _ExpenseIncomeRatioWidgetState();
}

class _ExpenseIncomeRatioWidgetState extends State<ExpenseIncomeRatioWidget>
    with SingleTickerProviderStateMixin {
  late double _currentRatio;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _currentRatio = widget.expenseToIncomeRatio;

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // Create animation with a curve for smooth transition
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Animate the circular percent indicator on ratio change
    _animationController.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(covariant ExpenseIncomeRatioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expenseToIncomeRatio != widget.expenseToIncomeRatio) {
      _currentRatio = widget.expenseToIncomeRatio;

      // Reset and animate the circular percent indicator on ratio change
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.expenseToIncomeRatio > 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Yikes! \n Spending > Income!\n Time for a budget-balance makeover!",
                  style: text_theme_h().copyWith(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                Lottie.asset("lib/assets/error.json", height: 120, width: 120),
                ElevatedButton(
                  style: button_theme_2(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BudgetCalculatorPage(),
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Go to Budget Calculator",
                          style: text_theme_h(),
                        ),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return CircularPercentIndicator(
                      radius: 280 * _animation.value,
                      lineWidth: 40,
                      percent: _currentRatio.clamp(0, 1),
                      center: Text(
                        'Expense to Income\nRatio: ${(_currentRatio * 100).toStringAsFixed(2)}%',
                        style: text_theme_h(),
                        textAlign: TextAlign.center,
                      ),
                      progressColor: Colors.red,
                    );
                  },
                ),
                SizedBox(height: 20),
                Container(
                  width: 240,
                  child: ElevatedButton(
                    style: button_theme_2(),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BudgetCalculatorPage(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Go to Budget Calculator",
                            style: text_theme_h().copyWith(fontSize: 15),
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
