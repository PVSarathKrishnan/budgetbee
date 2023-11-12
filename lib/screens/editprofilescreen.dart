import 'dart:io';

import 'package:budgetbee/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDE00), // Setting background color
      appBar: AppBar(
        title: Text("EDIT PROFILE"), // Setting app bar title
        iconTheme: IconThemeData(color: Colors.white), // Setting icon theme color
        centerTitle: true, // Centering the app bar title
        backgroundColor: Color.fromARGB(255, 0, 0, 0), // Setting app bar background color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Setting app bar shape
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/Background.png'), // Setting the background image
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ), // Providing space
                    Container(
                      width: 280,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "USERNAME", // Providing hint text
                              alignLabelWithHint: true,
                              labelText: "User Name", // Providing label text
                              labelStyle: GoogleFonts.poppins(), // Setting label text style
                              fillColor: Colors.white.withOpacity(.7), // Setting fill color
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ), // Providing space
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "EMAILID", // Providing hint text
                              alignLabelWithHint: true,
                              labelText: "Email id", // Providing label text
                              labelStyle: GoogleFonts.poppins(), // Setting label text style
                              fillColor: Colors.white.withOpacity(.7), // Setting fill color
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ), // Providing space
                          Container(
                            width: 180,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.7), // Setting container color
                              borderRadius: BorderRadius.circular(30), // Setting border radius
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Edit your profile image", // Displaying text
                                style: GoogleFonts.poppins(), // Setting text style
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ), // Providing space
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _image == null
                                  ? CircleAvatar(
                                      backgroundImage: AssetImage('lib/assets/profile.png'), // Setting profile image
                                      radius: 60,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(_image!), // Setting image file
                                      radius: 60,
                                    ),
                              SizedBox(width: 10,), // Providing space
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _getImage(ImageSource.camera);
                                    },
                                    child: Icon(Icons.camera, color: Colors.black), // Setting camera icon
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.white), // Setting button background color
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))), // Setting button shape
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _getImage(ImageSource.gallery);
                                    },
                                    child: Icon(Icons.folder_open, color: Colors.black), // Setting folder open icon
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(Colors.white), // Setting button background color
                                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))), // Setting button shape
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                              ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                            },
                            child: Text("SAVE CHANGES",style: GoogleFonts.poppins(color: const Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                            style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              backgroundColor: MaterialStatePropertyAll(
                                const Color.fromARGB(255, 0, 0, 0)
                                )
                                ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
