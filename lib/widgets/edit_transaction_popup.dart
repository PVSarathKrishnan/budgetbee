import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/db/category_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditIncomeTransactionPopup extends StatefulWidget {
  final int currentAmount;
  final String currentCategory;
  final DateTime currentDate;

  EditIncomeTransactionPopup({
    required this.currentAmount,
    required this.currentCategory,
    required this.currentDate,
  });

  @override
  _EditIncomeTransactionPopupState createState() =>
      _EditIncomeTransactionPopupState();
}

class _EditIncomeTransactionPopupState
    extends State<EditIncomeTransactionPopup> {
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  late String _selectedCategory;
  List<String> _defaultIncomeCategories =
      []; // Updated default income categories

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.currentAmount.toString());
    _selectedDate = widget.currentDate;
    _selectedCategory = widget.currentCategory;
    _loadDefaultIncomeCategories(); // Load default income categories
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _clearValues() {
    _amountController.clear();
    _selectedDate = widget.currentDate;
    _selectedCategory = '';
  }

  void _loadDefaultIncomeCategories() {
    // Load default income categories here
    final categoryFunctions = CategoryFunctions();
    _defaultIncomeCategories =
        categoryFunctions.getIncomeCategories().toSet().cast<String>().toList();

    // Check if the selected category is not empty
    if (_selectedCategory.isNotEmpty) {
      _selectedCategory =
          _selectedCategory; // Set the existing selected category
    } else {
      _selectedCategory =
          _defaultIncomeCategories.first; // Set the first category by default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: AlertDialog(
          title: Text('Edit Income Transaction'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
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
                      child: Text(category),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Date: '),
                    Text(
                      "${_selectedDate.day}/${DateFormat('MMM').format(_selectedDate)}/${_selectedDate.year}",
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text('Select Date'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                _editTransaction();
                _clearValues();
                Navigator.of(context).pop();
              },
              child: Text('Save Changes'),
            ),
            TextButton(
              onPressed: () {
                _clearValues();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
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
