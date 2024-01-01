import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/db/repositories/category_functions.dart';
import 'package:budgetbee/db/models/category_model.dart';
import 'package:budgetbee/db/models/transaction_modal.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditExpensePopup extends StatefulWidget {
  final int currentAmount;
  final String currentCategory;
  final DateTime currentDate;

  EditExpensePopup({
    required this.currentAmount,
    required this.currentCategory,
    required this.currentDate,
  });

  @override
  _EditExpensePopupState createState() => _EditExpensePopupState();
}

class _EditExpensePopupState extends State<EditExpensePopup> {
  late TextEditingController _amountController;
  late DateTime _selectedDate;
  late String _selectedCategory;
  List<String> _defaultIncomeCategories = [];
  List<TransactionModal> transactions = [];
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.currentAmount.toString());
    _selectedDate = widget.currentDate;
    _selectedCategory = widget.currentCategory;
    _loadDefaultIncomeCategories();
    fetchTransactions();
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
        categoryFunctions.getExpenseCategories().toList();

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
        title: Text('Edit Expense Transaction', style: text_theme_h()),
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
                  child: InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Material(
                      elevation: 6.0,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              'Date: ',
                              style: text_theme().copyWith(fontSize: 18),
                            ),
                            Text(
                              "${_selectedDate.day}/${DateFormat('MMM').format(_selectedDate)}/${_selectedDate.year}",
                              style: text_theme().copyWith(fontSize: 18),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.calendar_month_outlined),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(255, 135, 94, 201).withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              _editTransaction();
              _clearValues();
              fetchTransactions();
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
              style: text_theme().copyWith(color: Color(0xFF9486F7)),
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

    dbHelper.updateTransaction(
      widget.currentAmount,
      widget.currentDate,
      widget.currentCategory,
      updatedAmount,
      newDate,
      newCategory,
    );
  }

  Future<void> fetchTransactions() async {
    // Fetch transactions from the database
    List<TransactionModal> fetchedTransactions =
        await dbHelper.fetchTransactionData();
    setState(() {
      transactions = fetchedTransactions;
    });
  }
}
