import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:budgetbee/db/category_functions.dart';
import 'package:budgetbee/model/budget_calculator.dart';
import 'package:budgetbee/style/text_theme.dart';

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
  double amountLimit = 0;

  TextEditingController _amountLimitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryFunctions = CategoryFunctions();
    openBudgetBox();
    loadCategories();
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
    if (selectedCategory.isNotEmpty && amountLimit > 0) {
      final newBudgetCalculator = BudgetCalculator(
        category: selectedCategory,
        amountLimit: amountLimit,
      );

      setState(() {
        budgetCalculators.add(newBudgetCalculator);
        budgetBox.add(newBudgetCalculator);
        _amountLimitController.clear();
      });
    }
  }

  Future<void> loadCategories() async {
    await categoryFunctions.setupCategories();
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
          ? Center(child: Text('No budget calculators yet.'))
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
                          'Limit: \$${calculator.amountLimit.toStringAsFixed(2)}',
                          style: text_theme()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              _editBudgetCalculator(context, index);
                            },
                          ),
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
              Text('Select Category',
                  style: text_theme_h()
                      .copyWith(color: Color(0XFF9486F7), fontSize: 16)),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: defaultExpenseList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text('Enter Amount Limit',
                  style: text_theme_h()
                      .copyWith(color: Color(0XFF9486F7), fontSize: 16)),
              TextField(
                controller: _amountLimitController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amountLimit = double.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Enter Amount', hintStyle: text_theme()),
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

  void _editBudgetCalculator(BuildContext context, int index) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String newCategory = budgetCalculators[index].category;
        double newAmountLimit = budgetCalculators[index].amountLimit;

        return AlertDialog(
          title: Text('Edit Budget Calculator', style: text_theme_h()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Category', labelStyle: text_theme()),
                onChanged: (value) {
                  newCategory = value;
                },
                controller: TextEditingController(text: newCategory),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Amount Limit', labelStyle: text_theme()),
                onChanged: (value) {
                  newAmountLimit = double.tryParse(value) ?? 0;
                },
                controller:
                    TextEditingController(text: newAmountLimit.toString()),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text(
                'Cancel',
                style: text_theme_h()
                    .copyWith(color: Color(0XFF9486F7), fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                final updatedCalculator = BudgetCalculator(
                  category: newCategory,
                  amountLimit: newAmountLimit,
                );
                setState(() {
                  budgetCalculators[index] = updatedCalculator;
                  budgetBox.putAt(index, updatedCalculator);
                });
                Navigator.pop(context, updatedCalculator);
              },
              child: Text(
                'Save',
                style: text_theme_h()
                    .copyWith(color: Color(0XFF9486F7), fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSpentAmountBottomSheet(
      BuildContext context, BudgetCalculator calculator) {
    double spentAmount =
        100.0; // Replace this with your logic to calculate the spent amount

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spent Amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Category: ${calculator.category}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Amount Limit: \$${calculator.amountLimit.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Text(
                'Amount Spent: \$${spentAmount.toStringAsFixed(2)}', // Display the calculated spent amount here
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
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
}
