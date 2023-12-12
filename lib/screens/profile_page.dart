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
  TextEditingController _userTypeController = TextEditingController();
  TextEditingController _incomeLevelController = TextEditingController();

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
      _userTypeController.text = prefs.getString('userType') ?? '';
      _incomeLevelController.text = prefs.getString('incomeLevel') ?? '';
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('userType', _userTypeController.text);
    prefs.setString('incomeLevel', _incomeLevelController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(), // Apply font style here
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _userTypeController,
              decoration: InputDecoration(
                labelText: 'User Type',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(), // Apply font style here
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _incomeLevelController,
              decoration: InputDecoration(
                labelText: 'Income Level',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(), // Apply font style here
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveProfileData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated')),
                );
              },
              child: Text(
                'Save Changes',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                primary: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
