import 'dart:math';

import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/model/transaction_modal.dart';
import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/bnb_mainpage.dart';
import 'package:budgetbee/screens/about_screen.dart';
import 'package:budgetbee/screens/add_transaction.dart';
import 'package:budgetbee/screens/edit_profile_page.dart';
import 'package:budgetbee/screens/statistics_pag.dart';
import 'package:budgetbee/screens/tutorial_page.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:budgetbee/widgets/expensecard.dart';
import 'package:budgetbee/widgets/expensetile.dart';
import 'package:budgetbee/widgets/incomecard.dart';
import 'package:budgetbee/widgets/incometile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  getTotalBalance(List<TransactionModal> entireData) {
    // For the card in Home page
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (TransactionModal data in entireData) {
      if (data.type == "Income") {
        totalBalance += data.amount;
        totalIncome += data.amount;
      } else if (data.type == "Expense") {
        totalBalance -= data.amount;
        totalExpense += data.amount;
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
          leading: Tooltip(
            message: "Your'e in Home Page of BudgetBee",
            child: Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          title: Text(
            "BudgetBee",
            style: text_theme_hyper(),
          ),
          actions: [
            IconButton(
              onPressed: () {
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
                      color: Color(0XFF9486F7),
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
                      Icons.privacy_tip,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Privacy Policy', style: text_theme()),
                  ],
                ),
                onTap: () => _launchPPURL(
                    //To a external site where privacy policy of app
                    'https://www.freeprivacypolicy.com/live/3138d9d9-db48-4658-8f59-7626c7e75765'),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.help,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Get Help',
                        style: text_theme()), // Tutorial page (Incomplete)
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TutorialPage(),
                  ));
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
                //if any error occured
                return Center(
                  child: Text("Unexpected Error"),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return SingleChildScrollView(
                    child: Container(
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
                                  style:
                                      text_theme_p().copyWith(letterSpacing: 3),
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
                                      image: AssetImage("lib/assets/Logo.png")),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                getTotalBalance(snapshot.data!);

                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 18, bottom: 18, left: 18),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: []),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .8,
                      margin: EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              )
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
                            "Expense Tracker - ${DateFormat('MMMM').format(DateTime.now())}",
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
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StatPage(),
                                ));
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
                      child: FutureBuilder<List<PieChartSectionData>>(
                          future: getDataForPieChart(snapshot.data!),
                          builder: (context, pieSnapshot) {
                            if (pieSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (pieSnapshot.hasError) {
                              return Center(child: Text('Error loading data'));
                            } else if (pieSnapshot.hasData) {
                              if (pieSnapshot.data!.isEmpty) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          'Add expenses to see the pie chart.',
                                          style: text_theme_h().copyWith(
                                              color: Color(0XFF9486F7)),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Lottie.asset(
                                        "lib/assets/nodatachart.json",
                                        height: 100,
                                        width: 180,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: PieChart(PieChartData(
                                    sections: pieSnapshot.data!,
                                    sectionsSpace:
                                        1, // Adjust the space between sections as needed
                                    centerSpaceRadius: MediaQuery.of(context)
                                            .size
                                            .width *
                                        0.25, // Adjust the center hole radius
                                  )));
                            } else {
                              return Center(child: Text('No data available'));
                            }
                          }),
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
          ),
        );
      },
    );
  }

  //to launch url
  void _launchPPURL(String url) async {
    Uri url = Uri.parse(
        'https://www.freeprivacypolicy.com/live/ea5aba8f-705f-48cc-83f8-261ff8d2690f');
    if (await launchUrl(url)) {
      //dialer opened
    } else {
      SnackBar(content: Text("couldn't launch the page"));
    }
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

  Future<List<PieChartSectionData>> getDataForPieChart(
      List<TransactionModal> transactionData) async {
    // Fetching expense data
    Map<String, double> expenseNoteAmountMap =
        await dbHelper.fetchExpenseNoteAmountMap();

    // Process the fetched map data to create PieChartSectionData list
    List<PieChartSectionData> pieChartData =
        expenseNoteAmountMap.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        titleStyle: text_theme(),
        color: getRandomColor(),
      );
    }).toList();

    return pieChartData;
  }

  Color getRandomColor() {
    Random random = Random();

    // Generating random color components while avoiding banned colors
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    // Calculate color brightness using perceived luminance
    double colorBrightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    // Define brightness thresholds for text readability
    double darkThreshold = 100.0; // Adjust this threshold as needed
    double lightThreshold = 200.0; // Adjust this threshold as needed

    // Check if the color is too light or too dark
    if (colorBrightness < darkThreshold || colorBrightness > lightThreshold) {
      return getRandomColor(); // Recursively generate another color
    }

    return Color.fromARGB(255, red, green, blue);
  }
}
