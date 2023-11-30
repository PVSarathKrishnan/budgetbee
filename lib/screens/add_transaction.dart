import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

int? amount;
String note = "some Expense";
String type = "Income";
DateTime selectedDate = DateTime.now();

class _AddTransactionState extends State<AddTransaction> {
  String userEmail = "";
  UserModel? currentUser;
  @override
  void initState() {
    super.initState();
    // call the function to get the user
    getUser();
  }

  Future<void> getUser() async {
    // retrieving the current user email from shared preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // if the current user is null
    userEmail = prefs.getString("currentUser") ?? "";
    // checking the user in db using the same email
    final userBox = await Hive.openBox<UserModel>("user_db");
    currentUser = userBox.values.firstWhere((user) => user.email == userEmail);
    setState(() {});
  }

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 12),
      lastDate: DateTime(2120, 12),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Update selectedDate with the picked date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Color(0XFF9486F7),
        title: Text("ADD TRANSACTION"),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.attach_money_sharp),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "0", border: InputBorder.none),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      try {
                        amount = int.parse(value);
                      } catch (e) {}
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Icon(Icons.description),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Description", border: InputBorder.none),
                  maxLength: 24,
                  onChanged: (value) {
                    note = value;
                  },
                ),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(Icons.compare_arrows),
                SizedBox(
                  width: 12,
                ),
                ChoiceChip(
                  label: Text(
                    "Income",
                    style: TextStyle(
                      color: type == "Income"
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  selected: type == "Income" ? true : false,
                  selectedColor: Colors.green,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  label: Text(
                    "Expense",
                    style: TextStyle(
                      color: type == "Income"
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  selected: type == "Expense" ? true : false,
                  selectedColor: const Color.fromARGB(255, 255, 63, 50),
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        type = "Expense";
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  _selectDate(context);
                },
                style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                child: Row(
                  children: [
                    Icon(Icons.date_range, color: Colors.black),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "${selectedDate.day} ${months[selectedDate.month - 1]} ${selectedDate.year}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: button_theme(),
              onPressed: () async {
                if (amount != null && note.isNotEmpty) {
                  DbHelper dbHelper = DbHelper();
                  await dbHelper.addData(amount!, selectedDate, note, type);
                  Navigator.of(context).pop();
                } else {
                  return showSnackBar(context,"Can't add empty / Invalid data");
                }
              },
              child: Text("Add Transaction"),
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
    );
  }
    void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Color(0XFF9486F7),
      duration: Duration(seconds: 2),
    ));
  }
}
