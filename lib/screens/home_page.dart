import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/model/transaction_modal.dart';
import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/BNBmainpage.dart';
import 'package:budgetbee/screens/aboutscreen.dart';
import 'package:budgetbee/screens/add_name.dart';
import 'package:budgetbee/screens/add_transaction.dart';
import 'package:budgetbee/screens/profile_page.dart';
import 'package:budgetbee/screens/transactionhistory.dart';
import 'package:budgetbee/screens/unused_pages/editprofilescreen.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:budgetbee/widgets/expensecard.dart';
import 'package:budgetbee/widgets/expensetile.dart';
import 'package:budgetbee/widgets/incomecard.dart';
import 'package:budgetbee/widgets/incometile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userEmail = "";
  UserModel? currentUser;
  late SharedPreferences preferences;
  late Box box;
  bool sortAscending = true;
  DbHelper dbHelper = DbHelper();
  DateTime today = DateTime.now();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];

  List<FlSpot> getPlotPoints(List<TransactionModal> entireData) {
    Map<DateTime, int> dayWiseExpenses = {};

    entireData.forEach((data) {
      if (data.type == "Expense") {
        DateTime dateKey =
            DateTime(data.date.year, data.date.month, data.date.day);
        if (dayWiseExpenses.containsKey(dateKey)) {
          dayWiseExpenses[dateKey] = dayWiseExpenses[dateKey]! + data.amount;
        } else {
          dayWiseExpenses[dateKey] = data.amount;
        }
      }
    });

    // Convert the accumulated expenses map to FlSpot list
    List<FlSpot> dataSet = dayWiseExpenses.entries.map((entry) {
      return FlSpot(entry.key.day.toDouble(), entry.value.toDouble());
    }).toList();

    return dataSet;
  }

  getTotalBalance(List<TransactionModal> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (TransactionModal data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Income") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else if (data.type == "Expense") {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0XFFF5F6F8),
        appBar: AppBar(
          backgroundColor: Color(0XFF9486F7),
          toolbarHeight: 50,
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
          title: Text(
            "BudgetBee",
            style: text_theme_hyper_golden(),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // logOut(context);
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.settings, color: Colors.white),
            )
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 150,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0XFF9486F7), // Set primary color
                    ),
                    child: Text(
                      "Settings",
                      style: text_theme_color_size(Colors.white, 30),
                    )),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Profile', style: text_theme()),
                  ],
                ),
                onTap: () {
                  _showProfileModal(context);
                },
              ),
              ListTile(
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
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Logout', style: text_theme()),
                  ],
                ),
                onTap: () {
                  logOut(context);
                },
              ),
            ],
          ),
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
        body: FutureBuilder<List<TransactionModal>>(
            future: fetch(),
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
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Hello ${preferences.getString("name")}",
                          style: text_theme_hyper(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container()),
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
                // getPlotPoints(snapshot.data!);
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: []),
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
                            "Available Balance",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Expense Tracker - ${DateFormat('MMMM').format(selectedDate)}",
                            style: text_theme_h(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Color(0XFF9486F7),
                                borderRadius: BorderRadius.circular(60)),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  sortAscending = !sortAscending;
                                });
                              },
                              icon: Icon(
                                Icons.navigate_next_sharp,
                                size: 30,
                              ),
                              tooltip: "Explore more Statistics",
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 400,
                      padding: EdgeInsets.all(18),
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.4),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset: Offset(0, 4))
                          ]),
                      child: LineChart(LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: getPlotPoints(snapshot.data!),
                            isCurved: true,
                            color: Color(0XFF9486F7), // Color for the line

                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                      radius: 4,
                                      color: Color(
                                          0XFF9486F7)), // Set dot size and color here
                            ),
                            belowBarData: BarAreaData(
                                show: false), // To hide the area below the line
                            // You can add more styling properties as needed
                          )
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Transactions",
                            style: text_theme_h(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: Color(0XFF9486F7),
                                  borderRadius: BorderRadius.circular(60)),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MainTransactionPage(),
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
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length > 5
                          ? 5
                          : snapshot.data!
                              .length, // Show up to 5 items or less if available
                      itemBuilder: (context, index) {
                        TransactionModal dataAtIndex =
                            snapshot.data![snapshot.data!.length - index - 1];
                        if (dataAtIndex.type == "Income") {
                          return IncomeTile(
                              value: dataAtIndex.amount,
                              note: dataAtIndex.note,
                              date: dataAtIndex.date);
                        } else {
                          return ExpenseTile(
                              value: dataAtIndex.amount,
                              note: dataAtIndex.note,
                              date: dataAtIndex.date);
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

//log out
  void logOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Logout",
              style: text_theme_h(),
            ),
            content: Text(
              "Do you want to leave ?",
              style: text_theme(),
            ),
            actions: [
              ElevatedButton(
                  style: button_theme(),
                  onPressed: () {
                    signout(context);
                  },
                  child: Text("Yes", style: text_theme())),
              ElevatedButton(
                  style: button_theme(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No", style: text_theme())),
            ],
          );
        });
  }

//signout
  signout(BuildContext ctx) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => AddName()), (route) => false);
  }

  void _showProfileModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0XFF9486F7),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
          ),
        );
      },
    );
  }

  Future<List<TransactionModal>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModal> items = [];

      box.toMap().values.forEach((element) {
        items.add(TransactionModal(element["amount"] as int,
            element["date"] as DateTime, element["note"], element["type"]));
      });
      return items;
    }
  }

  void initState() {
    super.initState();
    getPreference();
    box = Hive.box("money");
    setState(() {});
  }
}
