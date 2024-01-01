
import 'package:budgetbee/presentation/screens/home_page/page/edit_profile_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewWidget extends StatelessWidget {
  const ProfileViewWidget({
    super.key,
    required this.preferences,
  });

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 180,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 254, 254),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Profile",
              style: text_theme_h().copyWith(color: Color(0XFF9486F7)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 390,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            preferences.getString("name") ?? 'Placeholder Name',
            style: text_theme_h().copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                preferences.getString("userType") ?? 'Placeholder',
                textAlign: TextAlign.center,
                style: text_theme()
                    .copyWith(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                preferences.getString("incomeLevel") ?? 'Placeholder',
                textAlign: TextAlign.center,
                style: text_theme().copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(),
                ),
              );
            },
            child: Container(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  Text("Edit Profile",
                      style: text_theme().copyWith(color: Colors.black)),
                ],
              ),
            ),
            style: button_theme().copyWith(
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 30)))),
      ],
    );
  }
}
