// import 'dart:io';
// import 'package:budgetbee/db/userfunctions.dart';
// import 'package:budgetbee/model/usermodel.dart';
// // import 'package:budgetbee/screens/homescreen.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   // final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   String userEmail = "";
//   UserModel? currentUser;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the user data
//     initialize();
//   }

//   // Fetch user details and set them in the state
//   initialize() {
//     getUser();
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

//   // Fetch user details from Hive database
//   Future<void> getUser() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     userEmail = prefs.getString("currentUser") ?? "";
//     final userBox = await Hive.openBox<UserModel>("user_db");
//     currentUser = userBox.values.firstWhere((user) => user.email == userEmail);
//     //currentUser = userBox.values.firstWhereOrNull((user) => user.email == userEmail);

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     int? id = currentUser?.id;
//     _nameController.text = currentUser?.name ?? '';
//     _emailController.text = currentUser?.email ?? '';

//     return Scaffold(
//         backgroundColor: Color(0xFFFFDE00),
//         appBar: AppBar(
//           title: Text("EDIT PROFILE"),
//           iconTheme: IconThemeData(color: Colors.white),
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 0, 0, 0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//         ),
//         body: currentUser != null
//             ? SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 90),
//                     Container(
//                       width: 300,
//                       child: Form(
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: _nameController,
//                               decoration: InputDecoration(
//                                 hintText: "NAME",
//                                 alignLabelWithHint: true,
//                                 labelStyle: GoogleFonts.poppins(),
//                                 fillColor: Colors.white.withOpacity(.7),
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 30),
//                             TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 hintText: "EMAIL ID",
//                                 alignLabelWithHint: true,
//                                 labelStyle: GoogleFonts.poppins(),
//                                 fillColor: Colors.white.withOpacity(.7),
//                                 filled: true,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Container(
//                       width: 180,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(.7),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Edit your profile image",
//                           style: GoogleFonts.poppins(),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _image == null
//                             ? CircleAvatar(
//                                 backgroundImage: AssetImage(''),
//                                 radius: 60,
//                               )
//                             : CircleAvatar(
//                                 backgroundImage:
//                                     FileImage(_image!.path as File),
//                                 radius: 60,
//                               ),
//                         SizedBox(width: 10),
//                         Column(
//                           children: [
//                             ElevatedButton(
//                               onPressed: () {
//                                 _getImage(ImageSource.camera);
//                               },
//                               child: Icon(Icons.camera, color: Colors.black),
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStatePropertyAll(Colors.white),
//                                 shape: MaterialStatePropertyAll(
//                                   RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(40),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 _getImage(ImageSource.gallery);
//                               },
//                               child:
//                                   Icon(Icons.folder_open, color: Colors.black),
//                               style: ButtonStyle(
//                                 backgroundColor:
//                                     MaterialStatePropertyAll(Colors.white),
//                                 shape: MaterialStatePropertyAll(
//                                   RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(40),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_image != null || id != null) {
//                           editProfile(
//                             id!,
//                             _nameController.text,
//                             _emailController.text,
//                             _image!.path,
//                           );
//                         } else {
//                           // Handle the case when _image or id is null
//                           print('Image or ID is null. Cannot save changes.');
//                         }
//                       },
//                       child: Text(
//                         "SAVE CHANGES",
//                         style: GoogleFonts.poppins(
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         shape: MaterialStatePropertyAll(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         backgroundColor: MaterialStatePropertyAll(
//                             Color.fromARGB(255, 0, 0, 0)),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : SingleChildScrollView());
//   }
// }
