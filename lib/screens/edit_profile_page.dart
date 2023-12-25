import 'package:budgetbee/data/category_data.dart';
import 'package:budgetbee/screens/home_page.dart';
import 'package:budgetbee/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController = TextEditingController();
  String? selectedUserType;
  String? selectedIncomeLevel;

  @override
  void initState() {
    super.initState();
    // Fetch profile data from SharedPreferences
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      selectedUserType = prefs.getString('userType');
      selectedIncomeLevel = prefs.getString('incomeLevel');
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('userType', selectedUserType ?? '');
    prefs.setString('incomeLevel', selectedIncomeLevel ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile', style: text_theme_h()),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color(0XFF9486F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
                  hintText: "Name",
                  labelText: "Enter your name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelStyle: GoogleFonts.poppins(),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.7),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
                style: text_theme_h(),
              ),
              SizedBox(height: 30.0),
              DropdownButtonFormField<String>(
                value: selectedUserType,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
                  hintText: "User Type",
                  labelText: "Select your user type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelStyle: GoogleFonts.poppins(),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.7),
                ),
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
              SizedBox(height: 30.0),
              DropdownButtonFormField<String>(
                value: selectedIncomeLevel,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.currency_rupee),
                  prefixIconColor: const Color.fromARGB(255, 93, 93, 93),
                  hintText: "Income Level",
                  labelText: "Select your income level",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelStyle: GoogleFonts.poppins(),
                  floatingLabelStyle: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(.7),
                ),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _saveProfileData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile updated',
                        style: text_theme_h(),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: Color(0XFF9486F7),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: button_theme(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
