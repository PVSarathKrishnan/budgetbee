// import 'package:budgetbee/screens/homescreen.dart';
import 'package:budgetbee/db/transactionfunction.dart';
import 'package:budgetbee/model/addtransactionmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

// Income
class _AddIncomeState extends State<AddIncome> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerIncome = TextEditingController();
  // final TextEditingController _descriptionControllerIncome =
  //     TextEditingController();
  final DateTime _incomeTime = DateTime.now();
  String? _selectedIncomeSource;

  List<String> incomeSourceOptions = [
    'Salary',
    'Freelancing',
    'Business Income',
    'Investments',
    'Rental Income',
    'Interest',
    'Dividends',
    'Gifts',
    'Bonus',
    'Refunds',
    'Other'
  ];
  @override
  void initState() {
    super.initState();
    // call the function to get the user
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5F6F8),
        appBar: AppBar(
          backgroundColor: Color(0XFF9486F7),
          toolbarHeight: 0,
          title: Text("ADD INCOME"),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 20),
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
                      "INCOME",
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
                    color:
                        const Color.fromARGB(255, 60, 244, 54).withOpacity(.9),
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
                      controller: _controllerIncome,
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
              validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter select an option';
                        }
                        return null;
                      },
                value: _selectedIncomeSource,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedIncomeSource = newValue;
                  });
                },
                items: incomeSourceOptions
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
                _controllerIncome.clear();  
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
                child: Lottie.asset("lib/assets/income.json",
                    height: 250, width: 250)),
          ]),
        ));
  }


}
