import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/db/models/transaction_modal.dart';
import 'package:budgetbee/presentation/common_widgets/dropdown_budget.dart';
import 'package:budgetbee/presentation/screens/budget_calculator_page/widget/nodata_budget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budgetbee/db/repositories/category_functions.dart';
import 'package:budgetbee/db/models/budget_calculator.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class BudgetCalculatorPage extends StatefulWidget {
  const BudgetCalculatorPage({Key? key}) : super(key: key);

  @override
  State<BudgetCalculatorPage> createState() => _BudgetCalculatorPageState();
}

class _BudgetCalculatorPageState extends State<BudgetCalculatorPage> {
  late Box<BudgetCalculator> budgetBox;
  late CategoryFunctions categoryFunctions;
  List<String> defaultExpenseList = [];
  List<BudgetCalculator> budgetCalculators = [];

  String selectedCategory = '';
  String amountLimit = '';

  TextEditingController _amountLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryFunctions = CategoryFunctions();
    selectedCategory =
        defaultExpenseList.isNotEmpty ? defaultExpenseList[0] : '';
    openBudgetBox();
    loadCategories();
    setState(() {});
  }

  Future<void> openBudgetBox() async {
    await Hive.openBox<BudgetCalculator>('budget_calculators');
    budgetBox = Hive.box<BudgetCalculator>('budget_calculators');
    loadBudgetCalculators();
  }

  Future<void> loadBudgetCalculators() async {
    setState(() {
      budgetCalculators = budgetBox.values.toList();
    });
  }

  void _addBudgetCalculator() {
    if (selectedCategory.isNotEmpty && amountLimit.isNotEmpty) {
      if (budgetCalculators
          .any((calculator) => calculator.category == selectedCategory)) {
        // If a calculator for this category already exists
        showToast('A calculator for this category already exists',
            context: context);
        return; // Exit the method
      }

      final newCalculator = BudgetCalculator(
        category: selectedCategory,
        amountLimit: double.parse(amountLimit),
      );

      budgetBox.add(newCalculator); // Add the new calculator to the box

      setState(() {
        budgetCalculators.add(newCalculator); // Update the list
      });
    }
  }

  Future<void> loadCategories() async {
    await categoryFunctions.getExpenseCategories();
    setState(() {
      defaultExpenseList = categoryFunctions
          .getExpenseCategories()
          .map((e) => e.name)
          .toSet()
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BUDGET CALCULATOR",
          style: text_theme_h(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color(0XFF9486F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: budgetCalculators.isEmpty
          ? nodata_widget()
          : ListView.builder(
              itemCount: budgetCalculators.length,
              itemBuilder: (context, index) {
                final calculator = budgetCalculators[index];
                return Card(
                  color: Color.fromARGB(255, 226, 226, 226),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        _showSpentAmountBottomSheet(context, calculator);
                      },
                      title:
                          Text('${calculator.category}', style: text_theme_h()),
                      subtitle: Text(
                        'Limit: \₹ ${calculator.amountLimit.toStringAsFixed(2)}',
                        style: text_theme(),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                budgetCalculators.removeAt(index);
                                budgetBox.deleteAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new one",
        backgroundColor: Color(0XFF9486F7),
        onPressed: () {
          _showAddBudgetCalculatorDialog(context);
        },
        child: Icon(Icons.add),
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _showAddBudgetCalculatorDialog(BuildContext context) async {
    selectedCategory =
        defaultExpenseList.isNotEmpty ? defaultExpenseList[0] : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Budget Calculator',
            style: text_theme_h(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Category',
                style: text_theme_h()
                    .copyWith(color: Color(0XFF9486F7), fontSize: 16),
              ),
              CategoryDropdown(
                defaultExpenseList: defaultExpenseList,
                onCategoryChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              SizedBox(height: 10),
              Text(
                'Enter Amount Limit',
                style: text_theme_h()
                    .copyWith(color: Color(0XFF9486F7), fontSize: 16),
              ),
              TextField(
                controller: _amountLimitController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amountLimit = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: text_theme(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: text_theme_h()
                    .copyWith(color: Color(0XFF9486F7), fontSize: 16),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0XFF9486F7))),
              onPressed: () {
                _addBudgetCalculator();
                _amountLimitController.clear();
                Navigator.pop(context);
              },
              child: Text(
                'Add',
                style: text_theme_h(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSpentAmountBottomSheet(
    BuildContext context,
    BudgetCalculator calculator,
  ) async {
    double spentAmount = await calculateSpentAmount(calculator.category);
    double remainingAmount = calculator.amountLimit - spentAmount;
    bool isOverLimit = remainingAmount < 0;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0XFF9486F7),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Budget Calculator',
                  style: text_theme_hyper().copyWith(color: Colors.white)),
              SizedBox(height: 10),
              Text('Category: ${calculator.category}', style: text_theme_h()),
              SizedBox(height: 5),
              Text(
                  'Amount Limit: \₹ ${calculator.amountLimit.toStringAsFixed(2)}',
                  style: text_theme_h()),
              SizedBox(height: 5),
              Text(
                'Amount Spent: ₹ ${spentAmount.toStringAsFixed(2)}',
                style: text_theme_h(),
              ),
              SizedBox(height: 5),
              Text('Remaining Amount: ₹ ${remainingAmount.toStringAsFixed(2)}',
                  style: text_theme_h().copyWith(
                      color: isOverLimit ? Colors.red : Colors.black)),
              SizedBox(height: 20),
              if (!isOverLimit && spentAmount <= calculator.amountLimit)
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 12.0,
                  animation: true,
                  animationDuration: 2000,
                  percent: spentAmount / calculator.amountLimit,
                  center: Text(
                    "${(spentAmount / calculator.amountLimit * 100).toStringAsFixed(2)}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor:
                      _getProgressColor(spentAmount, calculator.amountLimit),
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: button_theme_2(),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getProgressColor(double spentAmount, double amountLimit) {
    double percentage = spentAmount / amountLimit * 100;
    if (percentage <= 50) {
      return Colors.green;
    } else if (percentage > 50 && percentage <= 75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Future<double> calculateSpentAmount(String category) async {
    double spentAmount = 0.0;

    try {
      List<TransactionModal> transactions =
          await DbHelper().fetchTransactionData();

      for (var transaction in transactions) {
        if (transaction.note == category) {
          spentAmount += transaction.amount.toDouble();
        }
      }
    } catch (e) {
      // Handle any potential errors or exceptions when fetching transaction data
    }

    return spentAmount;
  }
}
