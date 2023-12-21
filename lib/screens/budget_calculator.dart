import 'package:flutter/material.dart';
import 'package:budgetbee/db/category_functions.dart'; // Import your category functions

class BudgetCalculatorPage extends StatefulWidget {
  const BudgetCalculatorPage({Key? key}) : super(key: key);

  @override
  State<BudgetCalculatorPage> createState() => _BudgetCalculatorPageState();
}

class _BudgetCalculatorPageState extends State<BudgetCalculatorPage> {
  late CategoryFunctions categoryFunctions;
  List<String> defaultExpenseList = []; // List to hold expense categories

  String selectedCategory = ''; // Store selected category
  double amountLimit = 0; // Store amount limit

  TextEditingController _addCategoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryFunctions = CategoryFunctions();
    loadCategories();
  }

  Future<void> loadCategories() async {
    await categoryFunctions.setupCategories();
    setState(() {
      defaultExpenseList =
          categoryFunctions.getExpenseCategories().map((e) => e.name).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF9486F7),
        title: Text(
          'Budget Calculator',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0XFF9486F7).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedCategory,
                hint: Text('Select Category'),
                isExpanded: true,
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
            ),
            SizedBox(height: 20),
            Text(
              'Enter Amount Limit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0XFF9486F7).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amountLimit = double.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Spending Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: 0.5, // Replace with your spending percentage
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Color(0XFF9486F7)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF9486F7),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add a Category',
            style: TextStyle(color: Color(0XFF9486F7)),
          ),
          content: TextField(
            controller: _addCategoryController,
            decoration: InputDecoration(
              hintText: 'Enter Category Name',
            ),
            onSubmitted: (String value) async {
              await _addCategory(value, context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addCategoryController.clear();
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _addCategory(_addCategoryController.text, context);
                _addCategoryController.clear();
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                primary: Color(0XFF9486F7),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCategory(String category, BuildContext context) async {
    if (category.isNotEmpty) {
      await categoryFunctions.addCategoryToDefaultList(category, 'Expense');
      loadCategories(); // Reload categories after adding a new one
      Navigator.pop(context);
    }
  }
}
