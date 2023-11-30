import 'package:budgetbee/main.dart';
import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/homescreen.dart';
import 'package:budgetbee/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 60,
            ),
            Container(
              height: 190,
              width: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 140,
                      width: 140,
                      child: Image(image: AssetImage("lib/assets/Logo.png"))),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
                width: 280,
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "LOGIN",
                    style: GoogleFonts.poppins(
                        fontSize: 28, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "We'd love to get to know you!",
                    style: GoogleFonts.comfortaa(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(children: [
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field
                          TextFormField(
                            controller: _emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              hintText: "Email",
                              labelText: "Enter your email id",
                              labelStyle: GoogleFonts.poppins(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(.7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            validator: validatePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "Enter your password",
                              labelStyle: GoogleFonts.poppins(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(.7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        
                        login(_emailController.text, _passwordController.text,
                            context);
                      },
                      child: Text(
                        "LOGIN",
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          backgroundColor: MaterialStatePropertyAll(
                              const Color.fromARGB(255, 0, 0, 0))),
                    ),
                  ]))
                ]))
          ]))),
    ));
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

  void login(String email, String password, BuildContext context) async {
    final userDB = await Hive.openBox<UserModel>("user_db");
    UserModel? user;
    for (var i = 0; i < userDB.length; i++) {
      final currentUser = userDB.getAt(i);
      if (currentUser?.email == email && currentUser?.password == password) {
        user = currentUser;
        break;
      }
    }
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(SAVE_KEY_NAME, true);
      await saveUserEmail(email);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Invalid Email or Password"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            );
          });
    }
  }

  Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("currentUser", email);
  }
}
