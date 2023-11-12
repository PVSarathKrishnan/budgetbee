import 'package:budgetbee/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40),
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
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "SIGNUP",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "We'd love to get to know you!",
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    validator: validateFullName,
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      labelText: "What should we call you?",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelStyle: GoogleFonts.poppins(),
                                      floatingLabelStyle: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(.7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorStyle: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontWeight: FontWeight.w500),
                                      alignLabelWithHint: true,
                                      // Set error text style
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    controller: _emailController,
                                    validator: validateEmail,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      labelText: "Enter your email id",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelStyle: GoogleFonts.poppins(),
                                      floatingLabelStyle: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(.7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorStyle: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontWeight: FontWeight.w500),
                                      alignLabelWithHint: true,
                                      // Set error text style
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    controller: _passwordController,
                                    validator: validatePassword,
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      labelText: "Choose a secure Password",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelStyle: GoogleFonts.poppins(),
                                      floatingLabelStyle: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(.7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorStyle: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontWeight: FontWeight.bold),
                                      alignLabelWithHint: true,
                                      // Set error text style
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    controller: _confirmpasswordController,
                                    validator: validateConfirmPassword,
                                    decoration: InputDecoration(
                                      hintText: "Confirm Password",
                                      labelText: "Re-enter your password",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      labelStyle: GoogleFonts.poppins(),
                                      floatingLabelStyle: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(.7),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide.none,
                                      ),
                                      errorStyle: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 255, 0, 0),
                                          fontWeight: FontWeight.bold),
                                      alignLabelWithHint: true,
                                      // Set error text style
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => WelcomeScreen(),
                                //     ));
                                AddUserFunction();
                              },
                              child: Text(
                                "SIGNUP",
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
                                      const Color.fromARGB(255, 0, 0, 0))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Name validator method
  String? validateFullName(String? value) {
  
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Full Name is required';
    }

    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

    if (!nameRegExp.hasMatch(trimmedValue)) {
      return 'Full Name can only contain letters and spaces';
    }

    return null; 
  }

// Email validator method
  String? validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return "Email is required";
    }
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegExp.hasMatch(trimmedValue)) {
      return "Invalid Email Address,";
    }
    return null;
  }

// Password Validator Method
  String? validatePassword(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Cannot be empty';
    }
    return null;
  }

// Confirm Password Method
    String? validateConfirmPassword(String? value) {
    final trimmedValue = value?.trim();

    if (trimmedValue == null || trimmedValue.isEmpty) {
      return "Cannot Be empty";
    }
    if(trimmedValue!=_passwordController.text){
    return 'Password must watch';
  }
    return null;
  }

  void AddUserFunction() {
    if (_formKey.currentState!.validate() &&
        _passwordController.text == _confirmpasswordController.text) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
    }
    // else{
    //   showSnackBar(context, 'User registration failed!');
    // }
  }





}
