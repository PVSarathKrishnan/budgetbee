
import 'package:budgetbee/presentation/screens/about_page/page/about_screen.dart';
import 'package:budgetbee/presentation/screens/home_page/page/tutorial_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class SettingsIcon extends StatelessWidget {
  const SettingsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0XFF9486F7),
          ),
          child: Text(
            "Settings",
            style: text_theme_color_size(Colors.white, 30),
          )),
    );
  }
}



class AboutUsIcon extends StatelessWidget {
  const AboutUsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            Icons.hdr_auto_sharp,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
          Text('About us', style: text_theme()),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutScreen(),
        ));
      },
    );
  }
}


class GetHelpIcon extends StatelessWidget {
  const GetHelpIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            Icons.help,
            color: Colors.black,
          ),
          SizedBox(
            width: 5,
          ),
          Text('Get Help', style: text_theme()),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TutorialPage(),
        ));
      },
    );
  }
}

