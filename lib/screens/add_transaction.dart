import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/db/budget_calculator_functions.dart';
import 'package:budgetbee/db/category_functions.dart';
import 'package:budgetbee/screens/budget_calculator_page.dart';
import 'package:budgetbee/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

BudgetCalculatorFunctions budgetFunctions = BudgetCalculatorFunctions();
TextEditingController _addCategoryController = TextEditingController();
TextEditingController _categoryTextController = TextEditingController();
late CategoryFunctions categoryFunctions;
int? amount;
String note = "Some Transaction";
String type = "Income";
DateTime selectedDate = DateTime.now();
String? selectedCategory;
String? _enteredText;

class _AddTransactionState extends State<AddTransaction> {
  Future<void> loadCategories() async {
    await Hive.initFlutter();
    categoryFunctions = CategoryFunctions();
    await categoryFunctions.setupCategories();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // call the function to get the user
    categoryFunctions = CategoryFunctions();
    if (categoryFunctions.getExpenseCategories().isEmpty ||
        categoryFunctions.getIncomeCategories().isEmpty) {
      loadCategories();
    }
    setState(() {}); //moved from getuser, commented it there because of error
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update selectedDate with the picked date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0XFF9486F7),
        title: Text(
          "ADD TRANSACTION",
          style: text_theme_h(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BudgetCalculatorPage(),
                ));
              },
              icon: Icon(Icons.addchart)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Text(
                        "Income",
                        style: text_theme_color_size(
                            type == "Income"
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : const Color.fromARGB(255, 0, 0, 0),
                            type == "Income" ? 22 : 16),
                      ),
                    ),
                    selected: type == "Income" ? true : false,
                    selectedColor: Color.fromARGB(255, 17, 187, 23),
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          amount = null;
                          note = "";
                          type = "Income";
                          selectedDate = DateTime.now();
                          selectedCategory = null;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Text("Expense",
                          style: text_theme_color_size(
                              type == "Income"
                                  ? const Color.fromARGB(255, 0, 0, 0)
                                  : const Color.fromARGB(255, 255, 255, 255),
                              type == "Income" ? 16 : 22)),
                    ),
                    selected: type == "Expense" ? true : false,
                    selectedColor: Color.fromARGB(255, 255, 35, 19),
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          amount = null;
                          note = "";
                          type = "Expense";
                          selectedDate = DateTime.now();
                          selectedCategory = null;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0XFF9486F7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF9486F7), // Background color
                        borderRadius: BorderRadius.circular(
                            18.0), // Optional: Customize border radius
                      ),
                      child: Icon(
                        Icons.currency_rupee_sharp,
                        size:
                            30, // Change the icon to currency_rupee or any desired icon
                        weight: 5,
                        color: Colors.white, // Icon color
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Background color for the text field
                          borderRadius: BorderRadius.circular(
                              18.0), // Optional: Customize border radius
                          border: Border.all(
                              color: Color(
                                  0xFF9486F7)), // Add a border to the TextField
                        ),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            maxLength: 8,
                            decoration: InputDecoration(
                                hintText: "0",
                                hintStyle: text_theme_hyper(),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        8.0), // Optional: Adjust content padding
                                counterText: ""),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            style: text_theme_hyper(),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              try {
                                amount = int.parse(value);
                              } catch (e) {}
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //TypeAheadFormField<String>(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0XFF9486F7),
                    ),
                    child: TypeAheadField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: _categoryTextController,
                          onChanged: (text) {
                            _enteredText = text;
                         
                          },
                          decoration: InputDecoration(
                            hintText: 'Search Category',
                            hintStyle: text_theme_color(Colors.white),
                            contentPadding: EdgeInsets.only(left: 8),
                            border: InputBorder.none,
                          ),
                          style: text_theme()),
                      suggestionsCallback: (String? pattern) {
                        final categories = type == 'Income'
                            ? categoryFunctions.getIncomeCategories()
                            : categoryFunctions.getExpenseCategories();

                        return categories
                            .where((item) => item.name
                                .toLowerCase()
                                .contains(pattern?.toLowerCase() ?? ''))
                            .map((category) => category
                                .name) // Extract the name from CategoryModel
                            .toList(); // Convert to a List<String>
                      },
                      itemBuilder: (BuildContext context, String? suggestion) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Color(0xff04CE9A),
                              border: Border(
                                  bottom: BorderSide(color: Colors.white))),
                          child: ListTile(
                            title: Text(
                              suggestion ?? '',
                              style: text_theme(),
                            ),
                          ),
                        );
                      },
                      noItemsFoundBuilder: (
                        BuildContext context,
                      ) {
                        return Container(
                            alignment: Alignment.center,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xff04CE9A),
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "If No match,type to add your own",
                                style:
                                    text_theme_color_size(Colors.white, 14.2),
                                textAlign: TextAlign.center,
                              ),
                            ));
                      },
                      onSuggestionSelected: (String? suggestion) {
                        setState(() {
                          if (suggestion != null && suggestion.isNotEmpty) {
                            _categoryTextController.text =
                                suggestion; // Update the text controller
                            selectedCategory = suggestion;
                            note = suggestion;
                          } else {
                            if (_enteredText != null &&
                                _enteredText!.isNotEmpty) {
                              _categoryTextController.text = _enteredText!;
                              selectedCategory = _enteredText!;
                              note = _enteredText!;
                            }
                          }
                        });
                      },
                      getImmediateSuggestions: true,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0XFF9486F7).withOpacity(.4),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        _showAddCategoryDialog(context);
                      },
                      icon: Icon(Icons.add),
                      tooltip: "Add a Category",
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    style: button_theme_1(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.date_range, color: Colors.black),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                              "${selectedDate.day} ${DateFormat('MMM').format(selectedDate)} ${selectedDate.year}",
                              style: text_theme_color(Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: button_theme(),
                onPressed: () async {
                  if (amount != null && note.isNotEmpty) {
                    if (selectedCategory != null) {
                      note = selectedCategory!;
                    } else if (_enteredText != null &&
                        _enteredText!.isNotEmpty) {
                      note = _enteredText!;
                    }

                    DbHelper dbHelper = DbHelper();
                    await dbHelper.addData(
                      amount!,
                      selectedDate,
                      note,
                      type,
                    );

                    setState(() {
                      amount = null;
                      note = "";
                      type = "Income";

                      selectedCategory = null;
                      _enteredText = "";
                      _categoryTextController.clear();
                    });

                    Navigator.of(context).pop();
                  } else {
                    return showSnackBar(
                        context, "Can't add empty / Invalid data");
                  }
                },
                child: Text(
                  "Add Transaction",
                  style: text_theme_color(Colors.black),
                ),
              ),
              Container(
                  child: type == 'Income'
                      ? Lottie.asset("lib/assets/income.json",
                          height: 300, width: 280)
                      : Lottie.asset("lib/assets/spend.json",
                          height: 300, width: 280))
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a Category',
              style: text_theme_h().copyWith(color: Color(0XFF9486F7))),
          content: TextField(
            controller: _addCategoryController,
            decoration: InputDecoration(
              hintText: 'Enter Category Name',
              hintStyle: text_theme()
                  .copyWith(color: Color.fromARGB(255, 149, 149, 149)),
            ),
            onSubmitted: (String value) async {
              // Add the submitted category to the default list
              await _addCategory(value, context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addCategoryController.clear();
                Navigator.pop(context); // Close the dialog without adding
              },
              child: Text(
                'Cancel',
                style: text_theme().copyWith(color: Color(0XFF9486F7)),
              ),
            ),
            TextButton(
              style: button_theme_1().copyWith(
                  backgroundColor: MaterialStatePropertyAll(Color(0XFF9486F7))),
              onPressed: () async {
                // Add the category to the default list
                await _addCategory(_addCategoryController.text, context);
                _addCategoryController.clear();
              },
              child: Text(
                'Add',
                style: text_theme_h().copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCategory(String category, BuildContext context) async {
    if (category.isNotEmpty) {
      // Add the category to the default list based on the current 'type'
      await categoryFunctions.addCategoryToDefaultList(category, type);

      _categoryTextController.clear();

      setState(() {
        selectedCategory = category;
      });

      Navigator.pop(context);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Color(0XFF9486F7),
      duration: Duration(seconds: 2),
    ));
  }
}
