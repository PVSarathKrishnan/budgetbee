// import 'dart:io';

// import 'package:budgetbee/db/userfunctions.dart';
// import 'package:budgetbee/model/usermodel.dart';
// import 'package:budgetbee/screens/loginscreen.dart';
// import 'package:budgetbee/style/text_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:image_picker/image_picker.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key? key}) : super(key: key);

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmpasswordController = TextEditingController();
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('lib/assets/Background.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(height: 60,),
//                 Container(
//                   width: 280,
//                   child: Column(
//                     children: [
//                       Text(
//                         "SIGNUP",
//                         style: text_theme_hyper()
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "We'd love to get to know you!",
//                         style: text_theme_p()
//                       ),
//                       // SizedBox(height: 15),
//                       // Container(
//                       //   width: 220,
//                       //   height: 30,
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white.withOpacity(.7),
//                       //     borderRadius: BorderRadius.circular(30),
//                       //   ),
//                       //   child: Align(
//                       //     alignment: Alignment.center,
//                       //     child: Text(
//                       //       "Choose your profile image",
//                       //       style: GoogleFonts.poppins(),
//                       //     ),
//                       //   ),
//                       // ),

//                                           ElevatedButton(
//                                             onPressed: () {
//                                               _getImage(ImageSource.gallery);
//                                             },
//                                             child: Icon(Icons.folder_open,
//                                                 color: Colors.black),
//                                             style: ButtonStyle(
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll(
//                                                 Colors.white.withOpacity(.5),
//                                               ),
//                                               shape: MaterialStatePropertyAll(
//                                                 RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(40),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   TextFormField(
//                                     controller: _nameController,
//                                     validator: validateFullName,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     decoration: InputDecoration(
//                                       prefixIconColor:
//                                           const Color.fromARGB(255, 93, 93, 93),
//                                       prefixIcon: Icon(Icons.person),
//                                       hintText: "Name",
//                                       labelText: "What should we call you?",
//                                       focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           borderSide:
//                                               BorderSide(color: Colors.black)),
//                                       labelStyle: GoogleFonts.poppins(),
//                                       floatingLabelStyle: GoogleFonts.poppins(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500),
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(.3),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                       errorStyle: GoogleFonts.poppins(
//                                           color: const Color.fromARGB(
//                                               255, 255, 0, 0),
//                                           fontWeight: FontWeight.bold),
//                                       alignLabelWithHint: true,
//                                       // Set error text style
//                                     ),
//                                   ),
//                                   SizedBox(height: 15),
//                                   TextFormField(
//                                     controller: _emailController,
//                                     validator: validateEmail,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     decoration: InputDecoration(
//                                       prefixIconColor:
//                                           const Color.fromARGB(255, 93, 93, 93),
//                                       prefixIcon: Icon(Icons.email),
//                                       hintText: "Email",
//                                       labelText: "Enter your email id",
//                                       focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           borderSide:
//                                               BorderSide(color: Colors.black)),
//                                       labelStyle: GoogleFonts.poppins(),
//                                       floatingLabelStyle: GoogleFonts.poppins(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500),
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(.3),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                       errorStyle: GoogleFonts.poppins(
//                                           color: const Color.fromARGB(
//                                               255, 255, 0, 0),
//                                           fontWeight: FontWeight.bold),
//                                       alignLabelWithHint: true,
//                                       // Set error text style
//                                     ),
//                                   ),
//                                   SizedBox(height: 15),
//                                   TextFormField(
//                                     controller: _passwordController,
//                                     validator: validatePassword,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     decoration: InputDecoration(
//                                       prefixIconColor:
//                                           const Color.fromARGB(255, 93, 93, 93),
//                                       prefixIcon: Icon(Icons.key),
//                                       hintText: "Password",
//                                       labelText: "Choose a secure Password",
//                                       focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           borderSide:
//                                               BorderSide(color: Colors.black)),
//                                       labelStyle: GoogleFonts.poppins(),
//                                       floatingLabelStyle: GoogleFonts.poppins(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500),
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(.3),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                       errorStyle: GoogleFonts.poppins(
//                                           color: const Color.fromARGB(
//                                               255, 255, 0, 0),
//                                           fontWeight: FontWeight.bold),
//                                       alignLabelWithHint: true,
//                                       // Set error text style
//                                     ),
//                                   ),
//                                   SizedBox(height: 15),
//                                   TextFormField(
//                                     controller: _confirmpasswordController,
//                                     validator: validateConfirmPassword,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     decoration: InputDecoration(
//                                       prefixIcon: Icon(Icons.verified_user),
//                                       prefixIconColor:
//                                           const Color.fromARGB(255, 93, 93, 93),
//                                       hintText: "Confirm Password",
//                                       labelText: "Re-enter your password",
//                                       focusedBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                           borderSide:
//                                               BorderSide(color: Colors.black)),
//                                       labelStyle: GoogleFonts.poppins(),
//                                       floatingLabelStyle: GoogleFonts.poppins(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500),
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(.3),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(30),
//                                         borderSide: BorderSide.none,
//                                       ),
//                                       errorStyle: GoogleFonts.poppins(
//                                           color: const Color.fromARGB(
//                                               255, 255, 0, 0),
//                                           fontWeight: FontWeight.bold),
//                                       alignLabelWithHint: true,
//                                       // Set error text style
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 15),
//                             ElevatedButton(
//                               onPressed: () {
//                                 if (_image == null) {
//                                   showSnackBar(context,
//                                       'Please select a profile image.');
//                                 } else {
//                                   AddUserButton();
//                                 }
//                               },
//                               child: Text(
//                                 "SIGNUP",
//                                 style: GoogleFonts.poppins(
//                                     color: const Color.fromARGB(
//                                         255, 255, 255, 255),
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               style: ButtonStyle(
//                                   shape: MaterialStatePropertyAll(
//                                       RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30))),
//                                   backgroundColor: MaterialStatePropertyAll(
//                                       const Color.fromARGB(255, 0, 0, 0))),
//                             ),
//                             SizedBox(height: 15),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => LoginScreen(),
//                                     ));
//                               },
//                               child: Text(
//                                 "Already have an account ?",
//                                 style: GoogleFonts.poppins(
//                                     color: const Color.fromARGB(
//                                         255, 255, 255, 255),
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               style: ButtonStyle(
//                                   shape: MaterialStatePropertyAll(
//                                       RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30))),
//                                   backgroundColor: MaterialStatePropertyAll(
//                                       const Color.fromARGB(255, 0, 0, 0))),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to pick an image from the gallery or camera
//   Future<void> _getImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
// // Image validator methpd

// // Name validator method
//   String? validateFullName(String? value) {
//     final trimmedValue = value?.trim();

//     if (trimmedValue == null || trimmedValue.isEmpty) {
//       return "Full Name is required";
//     }

//     final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

//     if (!nameRegExp.hasMatch(trimmedValue)) {
//       return 'Full Name can only contain letters and spaces';
//     }

//     return null;
//   }

// // Email validator method
//   String? validateEmail(String? value) {
//     final trimmedValue = value?.trim();
//     if (trimmedValue == null || trimmedValue.isEmpty) {
//       return "Email is required";
//     }
//     final RegExp emailRegExp =
//         RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
//     if (!emailRegExp.hasMatch(trimmedValue)) {
//       return "Invalid Email Address";
//     }
//     return null;
//   }

// // Password Validator Method
//   String? validatePassword(String? value) {
//     final trimmedValue = value?.trim();

//     if (trimmedValue == null || trimmedValue.isEmpty) {
//       return "Password field Cannot be empty";
//     }
//     return null;
//   }

// // Confirm Password Method
//   String? validateConfirmPassword(String? value) {
//     final trimmedValue = value?.trim();

//     if (trimmedValue == null || trimmedValue.isEmpty) {
//       return "Confirm password field Cannot be empty";
//     }
//     if (trimmedValue != _passwordController.text) {
//       return "Password Must be Same";
//     }
//     return null;
//   }

//   void usercheck(String email) async {
//     await Hive.openBox<UserModel>("user_db");
//     final userDB = Hive.box<UserModel>("user_db");
//     final userExists = userDB.values.any((user) => user.email == email);

//     if (userExists) {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text("Error"),
//               content: Text("User Already Exists"),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text("OK"))
//               ],
//             );
//           });
//     } else {
//       AddUserButton();
//     }
//   }

//   void AddUserButton() async {
//     final String name = _nameController.text.trim();
//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();
//     String imagePath = _image?.path ?? 'assets/profile1.png';

//     if (_formKey.currentState!.validate() &&
//         _passwordController.text == _confirmpasswordController.text) {
//       final _user = UserModel(
//         name: name,
//         email: email,
//         password: password,
//         photo: imagePath,
//       );
//       addUser(_user);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LoginScreen(),
//         ),
//       );
//     } else {
//       showSnackBar(context, 'User registration failed!');
//     }
//   }

//   void showSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//       duration: Duration(seconds: 1),
//     ));
//   }
// }
