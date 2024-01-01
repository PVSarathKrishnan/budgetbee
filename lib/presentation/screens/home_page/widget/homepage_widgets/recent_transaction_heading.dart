
import 'package:budgetbee/presentation/screens/bottom_nav_bar/page/bnb_mainpage.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:flutter/material.dart';

class RecentTransactionHeading extends StatelessWidget {
  const RecentTransactionHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Recent Transactions",
            style: text_theme_h(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 12.0,
            ),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: Color(0XFF9486F7),
                  borderRadius: BorderRadius.circular(60)),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) =>
                        MainTransactionPage(),
                  ));
                },
                icon: Icon(
                  Icons.navigate_next_sharp,
                  size: 30,
                ),
                tooltip: "View full transaction history",
              ),
            ),
          )
        ],
      ),
    );
  }
}
