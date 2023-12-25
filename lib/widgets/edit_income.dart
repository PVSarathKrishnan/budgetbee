import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/db/category_functions.dart';
import 'package:budgetbee/model/category_model.dart';
import 'package:budgetbee/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditIncomePopup extends StatefulWidget {
  final int currentAmount;
  final String currentCategory;
  final DateTime currentDate;

  EditIncomePopup({
    required this.currentAmount,
    required this.currentCategory,
    required this.currentDate,
  });

  @override
  _EditIncomePopupState createState() => _EditIncomePopupState();
}

class _EditIncomePopupState extends State<EditIncomePopup> {
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  late String _selectedCategory;
  List<String> _defaultIncomeCategories = [];

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.currentAmount.toString());
    _selectedDate = widget.currentDate;
    _selectedCategory = widget.currentCategory;
    _loadDefaultIncomeCategories();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _loadDefaultIncomeCategories() {
    // Load default income categories here
    final categoryFunctions = CategoryFunctions();
    List<CategoryModel> categoryModels =
        categoryFunctions.getIncomeCategories().toList();

    // Convert CategoryModel objects to strings
    _defaultIncomeCategories =
        categoryModels.map((category) => category.name).toList();

    // Check if the selected category is not empty
    if (_selectedCategory.isNotEmpty) {
      _selectedCategory =
          _selectedCategory; // Set the existing selected category
    } else {
      _selectedCategory =
          _defaultIncomeCategories.first; // Set the first category by default
    }
  }

  void _clearValues() {
    _amountController.clear();
    _selectedDate = widget.currentDate;
    _selectedCategory = '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text('Edit Income Transaction', style: text_theme_h()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: text_theme(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              hint: Text("$_selectedCategory", style: text_theme()),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                }
              },
              items: _defaultIncomeCategories
                  .map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category, style: text_theme()),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: text_theme(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF9486F7),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Text(
                          'Date: ',
                          style: text_theme(),
                        ),
                        Text(
                          "${_selectedDate.day}/${DateFormat('MMM').format(_selectedDate)}/${_selectedDate.year}",
                          style: text_theme(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Background color
                      backgroundColor: Color(0xFF9486F7), // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Button border radius
                      ),
                    ),
                    child: Icon(Icons.calendar_month_outlined)),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              _editTransaction();
              _clearValues();
              Navigator.of(context).pop();
            },
            style: button_theme_2(),
            child: Text(
              'Save Changes',
              style: text_theme(),
            ),
          ),
          TextButton(
            onPressed: () {
              _clearValues();
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: text_theme(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 12),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _editTransaction() {
    int updatedAmount =
        int.tryParse(_amountController.text) ?? widget.currentAmount;
    String newCategory = _selectedCategory;
    DateTime newDate = _selectedDate;

    // Implement your logic to update the transaction here
    DbHelper dbHelper = DbHelper();

    dbHelper.updateTransaction(
      widget.currentAmount, // Old amount
      widget.currentDate, // Old date
      widget.currentCategory, // Old category
      updatedAmount, // New amount
      newDate, // New date
      newCategory, // New category
    );

    // Close the edit popup after updating the transaction
  }
}
