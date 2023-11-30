import 'dart:ffi';

import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/home_page.dart';
import 'package:budgetbee/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String userEmail = "";
  UserModel? currentUser;
  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString("currentUser") ?? "";
    final userBox = await Hive.openBox<UserModel>("user_db");
    currentUser = userBox.values.firstWhere((user) => user.email == userEmail);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
    return Scaffold(
        body: Container(
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
                  SizedBox(
                    height: 200,
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                            height: 200,
                            width: 200,
                            child: Image(
                                image: AssetImage("lib/assets/Logo.png"))),
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
                          height: 20,
                        ),
                        Text(
                          "Hello ${currentUser?.name}",
                          style: GoogleFonts.dancingScript(
                            fontSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(height: 20),
                        Container(
                            child: Column(
                          children: [
                            Lottie.asset("lib/assets/Loading.json",
                                height: 100, width: 180)
                          ],
                        ))
                      ]))
                ]))));
  }
}
