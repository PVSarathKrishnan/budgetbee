
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerExpense = TextEditingController();
  final TextEditingController _descriptionControllerExpense =
      TextEditingController();
  final DateTime _expenseTime = DateTime.now();
  String? _selectedExpenseSource;
  List<String> expenseSourceOptions = [
    'Food',
    'Rent',
    'Utilities',
    'Transportation',
    'Insurance',
    'Healthcare',
    'Entertainment',
    'Clothing',
    'Education',
    'Gifts & Donations',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFDE00),
        appBar: AppBar(
          title: Text("ADD EXPENSE"),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20),
            // First section for Income
            // First section for Income
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "EXPENSE",
                      style: GoogleFonts.poppins(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Form(
                child: Column(
              children: [
                Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(167, 255, 0, 0).withOpacity(.8),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty || value == 0) {
                          return 'Enter a value';
                        }
                        return null;
                      },
                      controller: _controllerExpense,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                          size: 40,
                        ),
                        border: InputBorder.none,
                        hintText: "0",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 7),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              height: 40,
              child: DropdownButtonFormField(
                value: _selectedExpenseSource,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedExpenseSource = newValue;
                  });
                },
                items: expenseSourceOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Description",
                  alignLabelWithHint: true,
                  labelStyle: GoogleFonts.poppins(),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  fillColor: Colors.white.withOpacity(.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                    color: Colors.black), // Style for the selected item
                icon: Icon(
                  Icons.arrow_drop_down,
                ), // Custom dropdown icon
                iconEnabledColor: Colors.black, // Icon color
                dropdownColor:
                    Colors.white.withOpacity(.4), // Dropdown background color
              ),
            ),
            SizedBox(height: 20),
            // Elevated button for adding to income
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HomeScreen(),
                //     ));
                addExpenseButton();
                _controllerExpense.clear();
                _descriptionControllerExpense.clear();
              },
              child: Text(
                "ADD TO INCOME",
                style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                backgroundColor: MaterialStatePropertyAll(
                    const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            Container(
                child: Lottie.asset("lib/assets/spend.json",
                    height: 250, width: 250)),
          ]),
        ));
  }

  Future<void> addExpenseButton() async {
    final int amount = int.parse(_controllerExpense.text);
    final String decription = _descriptionControllerExpense.text.trim();
    final DateTime date = DateTime.now();
    final bool type = false;
    if (_formKey.currentState!.validate()) {}
  }
}
