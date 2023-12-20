import 'package:budgetbee/screens/expense_only.dart';
import 'package:budgetbee/screens/filter_page.dart';
import 'package:budgetbee/screens/income_only.dart';
import 'package:budgetbee/screens/transaction_history.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:flutter/material.dart';

class MainTransactionPage extends StatefulWidget {
  @override
  _MainTransactionPageState createState() => _MainTransactionPageState();
}

class _MainTransactionPageState extends State<MainTransactionPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TRANSACTION HISTORY",
          style: text_theme_h(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color(0XFF9486F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        actions: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0XFF9486F7).withOpacity(.4),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => FilterPage(),
                ));
              },
              icon: Icon(Icons.filter_alt),
            ),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _getBodyWidget(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0XFF9486F7),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_up),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'All Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_circle_down),
            label: 'Expense',
          ),
        ],
        selectedLabelStyle: text_theme_color_size(Color(0XFF9486F7), 15),
        selectedIconTheme: IconThemeData(size: 35),
        unselectedLabelStyle:
            text_theme_color_size(Colors.black.withOpacity(.5), 11),
      ),
    );
  }

  Widget _getBodyWidget(int index) {
    switch (index) {
      case 0:
        return IncomeOnly();
      case 1:
        return TransactionHistoryScreen();
      case 2:
        return ExpenseOnly();
      default:
        return TransactionHistoryScreen();
    }
  }
}
