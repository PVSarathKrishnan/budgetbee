import 'package:budgetbee/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _controllerIncome = TextEditingController();
  final TextEditingController _controllerExpense = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerExpense.text = "₹0";
    _controllerIncome.text = "₹0"; // Set the default value for the controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFDE00),
        appBar: AppBar(
          title: Text("ADD TRANSACTION"),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // First section for Income
                    // First section for Income
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Container for "Income" title
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
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Container for Income value
                    Container(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 60, 244, 54)
                                    .withOpacity(.9),
                              ),
                              child: Center(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: _controllerIncome,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "₹0",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 7),
                                      hintStyle: TextStyle(color: Colors.white),
                                    ),
                                    onChanged: (value) {
                                      if (!value.startsWith("₹")) {
                                        _controllerIncome.text = "₹" + value;
                                        _controllerIncome.selection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: _controllerIncome
                                                        .text.length));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // TextFormField for income source
                            Container(
                              width: 200,
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Type Your Income Source",
                                  labelText: "Description",
                                  alignLabelWithHint: true,
                                  labelStyle: GoogleFonts.poppins(),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 50),
                                  fillColor: Colors.white.withOpacity(.7),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Elevated button for adding to income
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              },
                              child: Text(
                                "ADD TO INCOME",
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                backgroundColor: MaterialStatePropertyAll(
                                    const Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            SizedBox(height: 30),
                            // Separator line
                            Container(
                              width: double.infinity,
                              height: 5,
                              color: Colors.white.withOpacity(.5),
                            ),
                            SizedBox(height: 20),
                            // Second part for Expense
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Container for "Expense" title
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
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Container for Expense value
                            Container(
                              width: 200,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.red.withOpacity(.9),
                              ),
                              child: Center(
                                child: Align(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: _controllerExpense,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "0",
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 7),
                                      hintStyle: TextStyle(color: Colors.white),
                                    ),
                                    onChanged: (value) {
                                      if (!value.startsWith("₹")) {
                                        _controllerExpense.text = "₹" + value;
                                        _controllerExpense.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                              offset: _controllerExpense.text.length),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // TextFormField for expense description
                            Container(
                              width: 200,
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Type Your Expense",
                                  labelText: "Description",
                                  alignLabelWithHint: true,
                                  labelStyle: GoogleFonts.poppins(),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 50),
                                  fillColor: Colors.white.withOpacity(.7),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            // Elevated button for adding to expense
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ));
                              },
                              child: Text(
                                "ADD TO EXPENSE",
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                backgroundColor: MaterialStatePropertyAll(
                                    const Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
