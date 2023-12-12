import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/data/category_data.dart';
import 'package:budgetbee/screens/home_page.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddName extends StatefulWidget {
  const AddName({Key? key});

  @override
  State<AddName> createState() => _AddNameState();
}

class _AddNameState extends State<AddName> {
  DbHelper dbHelper = DbHelper();
  String name = "";
  String? selectedUserType;
  String? selectedImagePath;
  String? selectedIncomeLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/Background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 60),
        Container(
          height: 190,
          width: 200,
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                height: 140,
                width: 140,
                child: Image(image: AssetImage("lib/assets/Logo.png")),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Container(
          width: 280,
          child: Column(children: [
            SizedBox(height: 10),
            Text("We'd love to get to know you!", style: text_theme()),
            SizedBox(height: 40),

            TextFormField(
              onChanged: (value) {
                name = value;
              },
              validator: validateFullName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
                hintText: "Name",
                labelText: "Enter your name",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                labelStyle: GoogleFonts.poppins(),
                floatingLabelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(.7),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.red, width: 1.5),
                ),
                errorStyle: TextStyle(color: Colors.red),
                errorMaxLines: 2,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),

            SizedBox(height: 20),
            // User Type Dropdown
            Container(
              width: 280,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.7),
                ),
                value: selectedUserType,
                hint: Text('Select your job category'),
                items: userTypes.map((String userType) {
                  return DropdownMenuItem<String>(
                    value: userType,
                    child: Text(userType),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUserType = newValue;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 280,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.currency_rupee),
                  prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.7),
                ),
                elevation: 8,
                dropdownColor: Colors.white,
                value: selectedIncomeLevel,
                hint: Text('Select Income Level'),
                items: incomeLevels.map((String income) {
                  return DropdownMenuItem<String>(
                    value: income,
                    child: Text(income),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedIncomeLevel = newValue;
                  });
                },
              ),
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (name.isNotEmpty &&
                    selectedUserType != null &&
                    selectedIncomeLevel != null) {
                  // Save name, user type, and income level to SharedPreferences
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('name', name);
                  prefs.setString('userType', selectedUserType!);
                  prefs.setString('incomeLevel', selectedIncomeLevel!);

                  // Add name to the database
                  dbHelper.addName(name);

                  // Move to HomePage
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                } else {
                  showSnackBar(context, "Please fill in all fields");
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Let's get started ",
                    style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.navigate_next_outlined)
                ],
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),

            SizedBox(height: 20),
          ]),
        ),
      ]),
    ))));
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
      ),
    );
  }

  String? validateFullName(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return "Full Name is required";
    }

    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

    if (!nameRegExp.hasMatch(trimmedValue)) {
      return 'Full Name can only contain letters and spaces';
    }

    return null;
  }
}
