import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class text_widget extends StatelessWidget {
  const text_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 170),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Setting border radius
              color: Colors.white.withOpacity(.7), // Setting container color
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 11, left: 11, right: 11),
                  child: Text(
                      "BudgetBee is your go-to solution for effortless financial management. Our intuitive platform equips you with the tools and insights needed to take charge of your finances. From smart budgeting to comprehensive analytics, BudgetBee paves the way towards achieving your financial aspirations, hassle-free.",
                      textAlign: TextAlign.center,
                      style: text_theme_p()
                          .copyWith(letterSpacing: 1, fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 180,
        ),
        Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255)
                    .withOpacity(.3), // Setting container color
                borderRadius:
                    BorderRadius.circular(12), // Setting border radius
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.navigate_before),
                iconSize: 35,
                color: Colors.black.withOpacity(.65),
              ),
            )
          ],
        ),
      ],
    );
  }
}
