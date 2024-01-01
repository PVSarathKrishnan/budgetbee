
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.preferences,
  });

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: 250,
            child: Column(
              children: [
                Text(
                  '"Know what you own, and know why you own it"',
                  style: text_theme_p(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "- Peter Lynch -",
                  style: text_theme_p()
                      .copyWith(letterSpacing: 3),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Hello ${preferences.getString("name")}",
            style: text_theme_h(),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container()),
          Lottie.asset("lib/assets/nodata.json",
              height: 100, width: 180),
          SizedBox(
            height: 20,
          ),
          Text(
            "No values Found,Try Adding Income first.",
            style: text_theme_p(),
          ),
          Container(
            height: 190,
            width: 200,
            child: Column(
              children: [
                SizedBox(height: 30),
                Container(
                  height: 100,
                  width: 100,
                  child: Image(
                      image: AssetImage(
                          "lib/assets/Logo.png")),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
