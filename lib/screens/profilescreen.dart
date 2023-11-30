import 'dart:io';
import 'package:budgetbee/model/usermodel.dart';
// import 'package:budgetbee/screens/editprofilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // File? _image;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFDE00),
        appBar: AppBar(
          title: Text("PROFILE"),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        body: currentUser != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/assets/Background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 90,
                            ),
                            Container(
                              width: 280,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),

                                  CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(currentUser!.photo)),
                                    radius: 60,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    width: 370,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white.withOpacity(.7),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "${currentUser?.name ?? " "}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(.6),
                                      ),
                                    ).animate().fade(duration: 500.ms)),
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    width: 370,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white.withOpacity(.7),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "${currentUser?.email}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(.6),
                                      ),
                                    ).animate().fade(duration: 500.ms)),
                                  ),
                                  SizedBox(height: 20),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => EditProfileScreen(),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Text(
                                  //     "Edit Profile",
                                  //     style: GoogleFonts.poppins(
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  //   style: ButtonStyle(
                                  //     shape: MaterialStatePropertyAll(
                                  //       RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(30),
                                  //       ),
                                  //     ),
                                  //     backgroundColor: MaterialStatePropertyAll(
                                  //       const Color.fromARGB(255, 0, 0, 0),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView());
  }
}
