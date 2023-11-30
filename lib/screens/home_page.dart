import 'dart:io';

import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/add_transaction.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:budgetbee/widgets/expensecard.dart';
import 'package:budgetbee/widgets/expensetile.dart';
import 'package:budgetbee/widgets/incomecard.dart';
import 'package:budgetbee/widgets/incometile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userEmail = "";
  UserModel? currentUser;
  @override
  void initState() {
    super.initState();
    // call the function to get the user
    getUser();
  }

  Future<void> getUser() async {
    // retrieving the current user email from shared preference
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // if the current user is null
    userEmail = prefs.getString("currentUser") ?? "";
    // checking the user in db using the same email
    final userBox = await Hive.openBox<UserModel>("user_db");
    currentUser = userBox.values.firstWhere((user) => user.email == userEmail);
    setState(() {});
  }

  bool sortAscending = true;
  DbHelper dbHelper = DbHelper();
  DateTime today = DateTime.now();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];

  List<FlSpot> getPlotPoints(Map entireData) {
    dataSet = [];
    entireData.forEach((key, value) {
      if (value['type'] == "Expense") {
        dataSet.add(FlSpot(
        (value['date'] as DateTime).day.toDouble(), // Using day as y-axis value
        (value['amount']).toDouble(), // Using amount as x-axis value
      ));
      }
    });
    return dataSet;
  }

  getTotalBalance(Map entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    entireData.forEach((key, value) {
      if (value['type'] == "Income") {
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      } else {
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF5F6F8),
        appBar: AppBar(
          // backgroundColor: Color(0XFF9486F7),
          toolbarHeight: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddTransaction(),
            ))
                .whenComplete(() {
              setState(() {});
            });
          },
          backgroundColor: Color(0XFF9486F7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Icon(
            Icons.add,
            size: 32,
          ),
        ),
        body: FutureBuilder<Map>(
            future: dbHelper.fetch(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Unexpected Error"),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 180),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  FileImage(File(currentUser!.photo)),
                              radius: 60,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Hello ${currentUser!.name}",
                              style: text_theme(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container()),
                          ],
                        ),
                        Lottie.asset("lib/assets/nodata.json",
                            height: 100, width: 180),
                        Text(
                          "No values Found,Try Adding Income first.",
                          style: text_theme(),
                        ),
                      ],
                    ),
                  );
                }
                getTotalBalance(snapshot.data!);
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(currentUser!.photo)),
                                    radius: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${currentUser!.name}",
                                      style: text_theme_h(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.settings),)
                            )
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .8,
                      margin: EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(.7),
                                  blurRadius: 4,
                                  blurStyle: BlurStyle.outer,
                                  spreadRadius: 3)
                            ],
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 162, 151, 248),
                              Color.fromARGB(255, 164, 152, 250),
                              Color.fromARGB(255, 150, 137, 253),
                              Color.fromARGB(255, 164, 152, 250),
                              Color.fromARGB(255, 162, 151, 248),
                            ])),
                        padding: EdgeInsets.all(12),
                        child: Column(children: [
                          Text(
                            "Total Balance",
                            style: text_theme_h(),
                          ),
                          Text(
                            "${totalBalance}",
                            style: text_theme_h(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardIncome(value: "${totalIncome}"),
                                SizedBox(
                                  width: 50,
                                ),
                                cardEpense(value: "${totalExpense}")
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Expenses",
                        style: text_theme_h(),
                      ),
                    ),
                    dataSet.isNotEmpty 
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.3),
                                        blurRadius: 2)
                                  ]),
                              height: 300.0,
                              child: LineChart(
                                LineChartData(lineBarsData: [
                                  LineChartBarData(
                                      spots: getPlotPoints(snapshot.data!),
                                      isCurved: true,
                                      barWidth: 3,
                                      color: Colors.deepPurple)
                                ]),
                              ),
                            ),
                          )
                        : Container(
                            child: Center(
                              child: Text(
                                "Not Enough data to render  the graph",
                                style: text_theme(),
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Transactions",
                            style: text_theme_h(),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  sortAscending = !sortAscending;
                                });
                              },
                              icon: Icon(
                                Icons.swap_vert,
                              ))
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          snapshot.data != null ? snapshot.data!.length : 0,
                      itemBuilder: (context, index) {
                        Map dataAtIndex = sortAscending
                            ? snapshot.data![index]
                            : snapshot.data![snapshot.data!.length - index - 1];
                        if (dataAtIndex['type'] == "Income") {
                          return incomeTile(
                              value: dataAtIndex['amount'],
                              note: dataAtIndex['note'],
                              date: dataAtIndex['date']);
                        } else {
                          return ExpenseTile(
                              value: dataAtIndex['amount'],
                              note: dataAtIndex['note'],
                              date: dataAtIndex['date']);
                        }
                      },
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text("Unexpected Error"),
                );
              }
            }));
  }

  void swaptransaction() {}
}
