import 'dart:async';
import 'dart:math';
import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/db/repositories/budget_calculator_functions.dart';
import 'package:budgetbee/db/models/budget_calculator.dart';
import 'package:budgetbee/db/models/reminder_model.dart';
import 'package:budgetbee/db/models/transaction_modal.dart';
import 'package:budgetbee/presentation/screens/bottom_nav_bar/page/bnb_mainpage.dart';
import 'package:budgetbee/presentation/screens/about_page/page/about_screen.dart';
import 'package:budgetbee/presentation/screens/add_transaction_screen/page/add_transaction.dart';
import 'package:budgetbee/presentation/screens/budget_calculator_page/page/budget_calculator_page.dart';
import 'package:budgetbee/presentation/screens/home_page/page/delete_splash.dart';
import 'package:budgetbee/presentation/screens/home_page/page/edit_profile_page.dart';
import 'package:budgetbee/presentation/screens/reminder_page/page/reminder_screen.dart';
import 'package:budgetbee/presentation/screens/statistics_page/page/statistics_page.dart';
import 'package:budgetbee/presentation/screens/home_page/page/tutorial_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:budgetbee/presentation/common_widgets/expense_card.dart';
import 'package:budgetbee/presentation/common_widgets/expense_income_widget.dart';
import 'package:budgetbee/presentation/common_widgets/expense_tile.dart';
import 'package:budgetbee/presentation/common_widgets/income_card.dart';
import 'package:budgetbee/presentation/common_widgets/income_tile.dart';
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
  late Timer timer;
  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String userEmail = "";
  late SharedPreferences preferences;
  late Box box;
  bool sortAscending = true;
  DbHelper dbHelper = DbHelper();
  DateTime today = DateTime.now();
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  double expenseToIncomeRatio = 0;
  List<FlSpot> dataSet = [];
  BudgetCalculatorFunctions budgetCalculatorFunctions =
      BudgetCalculatorFunctions();
  List<BudgetCalculator> budgetCalculators = [];
  List<TransactionModal> transactions = [];
  Map<String, Color> categoryColorMap = {};
  @override
  void initState() {
    super.initState();
    runDelayedFunction();
    getPreference();
    box = Hive.box("money");
    getBudgetCalculators();
    fetchTransactions();
  }

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
      expenseToIncomeRatio = (totalExpense / totalIncome);
    }
  }

  Future<void> fetchTransactions() async {
    // Fetch transactions from the database

    List<TransactionModal> fetchedTransactions =
        await dbHelper.fetchTransactionData();
    setState(() {
      transactions = fetchedTransactions;
    });
  }

  Future<void> getBudgetCalculators() async {
    try {
      List<BudgetCalculator> fetchedCalculators =
          await budgetCalculatorFunctions.fetchBudgetCalculators();
      setState(() {
        budgetCalculators = fetchedCalculators;
      });
    } catch (e) {}
  }

// Deletion function
  Future<void> deleteTransaction(
      BuildContext context, TransactionModal transaction) async {
    try {
      // Perform the deletion
      DbHelper dbHelper = DbHelper();
      await dbHelper.deleteTransaction(
        transaction.amount,
        transaction.date,
        transaction.note,
      );

      await fetchTransactions();

      getTotalBalance(transactions);

      setState(() {});

      print('Transaction deleted');
    } catch (e) {
      print('Error deleting transaction: $e');
      // Handle deletion errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    runDelayedFunction();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0XFFF5F6F8),
        appBar: AppBar(
          backgroundColor: Color(0XFF9486F7),
          toolbarHeight: 50,
          leading: Tooltip(
            message: "Set reminder",
            child: IconButton(
              icon: Icon(
                Icons.alarm_add_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReminderPage(),
                ));
              },
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
            ),
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
                    'https://www.freeprivacypolicy.com/live/ea5aba8f-705f-48cc-83f8-261ff8d2690f'),
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
                    Text('Get Help', style: text_theme()),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TutorialPage(),
                  ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.dangerous_rounded,
                        color: Color.fromARGB(255, 255, 0, 0)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Reset All data',
                        style: text_theme()
                            .copyWith(color: Color.fromARGB(255, 255, 0, 0))),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showWarning(context);
                    },
                  );
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
        body: RefreshIndicator(
            color: Color(0XFF9486F7),
            backgroundColor: Colors.white,
            displacement: 50,
            strokeWidth: 3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              await fetchTransactions();
              setState(() {});
            },
            child: FutureBuilder<List<TransactionModal>>(
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
                                "₹ ${totalBalance}",
                                style: text_theme_h(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    cardIncome(value: "₹ ${totalIncome}"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    cardEpense(value: "₹ ${totalExpense}")
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => StatPage(
                                        totalBalance: totalBalance,
                                        totalIncome: totalIncome,
                                        totalExpense: totalExpense,
                                      ),
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
                                if (pieSnapshot.hasError) {
                                  return Center(
                                      child: Text('Error loading data'));
                                } else if (pieSnapshot.hasData) {
                                  if (pieSnapshot.data!.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        centerSpaceRadius: MediaQuery.of(
                                                    context)
                                                .size
                                                .width *
                                            0.25, // Adjust the center hole radius
                                      )));
                                } else {
                                  return Center(
                                      child: Text('No data available'));
                                }
                              }),
                        ),
                        Padding(
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
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length > 5
                              ? 5
                              : snapshot.data!
                                  .length, // Show up to 5 items or less if available
                          itemBuilder: (context, index) {
                            TransactionModal dataAtIndex = snapshot
                                .data![snapshot.data!.length - index - 1];
                            if (dataAtIndex.type == "Income") {
                              return IncomeTile(
                                  value: dataAtIndex.amount,
                                  note: dataAtIndex.note,
                                  date: dataAtIndex.date);
                            } else {
                              return ExpenseTile(
                                value: dataAtIndex.amount,
                                note: dataAtIndex.note,
                                date: dataAtIndex.date,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Budget Plans",
                                style: text_theme_h(),
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            BudgetCalculatorPage(),
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
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 420,
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
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: ExpenseIncomeRatioWidget(
                                      expenseToIncomeRatio:
                                          expenseToIncomeRatio)),
                            ),
                          ],
                        ),
                        Container(
                          height: 40,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("Unexpected Error"),
                    );
                  }
                })));
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
      //browser opened
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

  Color getRandomColorForCategory(String category) {
    // Check if the category has an associated color in the map
    if (categoryColorMap.containsKey(category)) {
      return categoryColorMap[category]!;
    }

    // If the category doesn't have a color yet, generate a new color
    Color newColor = _generateRandomColor();

    // Assign the new color to the category in the map
    categoryColorMap[category] = newColor;

    return newColor;
  }

  Color _generateRandomColor() {
    Random random = Random();

    // Generating random color components while avoiding banned colors
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    // Calculate color brightness using perceived luminance
    double colorBrightness = (red * 0.299 + green * 0.587 + blue * 0.114);

    // Define brightness for text readability
    double darkThreshold = 100.0;
    double lightThreshold = 200.0;
    if (colorBrightness < darkThreshold || colorBrightness > lightThreshold) {
      return _generateRandomColor();
    }

    return Color.fromARGB(255, red, green, blue);
  }

  Future<List<PieChartSectionData>> getDataForPieChart(
      List<TransactionModal> transactionData) async {
    // Fetching expense data
    Map<String, double> expenseNoteAmountMap =
        await dbHelper.fetchExpenseNoteAmountMap();

    // Process the fetched map
    List<PieChartSectionData> pieChartData =
        expenseNoteAmountMap.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        titleStyle: text_theme_h(),
        color:
            getRandomColorForCategory(entry.key), // Get color for each category
      );
    }).toList();

    return pieChartData;
  }

  AlertDialog showWarning(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Warning!',
          style: text_theme_h()
              .copyWith(color: const Color.fromARGB(255, 255, 17, 0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you sure you want to erase all data?',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: text_theme().color),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'This action will delete all the data permanently!',
            style: text_theme_p().copyWith(
                fontSize: 15, color: Color.fromARGB(255, 111, 111, 111)),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            // Clearing Hive boxes
            await Hive.box('money').clear();
            await Hive.box('categories').clear();
            await Hive.box("expenseCategoryBox").clear();
            await Hive.box("incomeCategoryBox").clear();
            await Hive.box<BudgetCalculator>('budget_calculators').clear();
            await Hive.box('budgetCalculatorBox').clear();
            await Hive.box<Reminder>('remindersbox').clear();

            // Clearing shared preferences
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => DeleteSplashScreen(),
            ));
          },
          child: Text(
            'Delete ',
            style:
                text_theme_h().copyWith(color: Color.fromARGB(255, 255, 0, 0)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: text_theme_h().copyWith(color: Color(0XFF9486F7)),
          ),
        ),
      ],
    );
  }

  void delayedFunction() {
    setState(() {});
  }

  Future<void> runDelayedFunction() async {
    // Use Future.delayed to create a delayed Future
    await Future.delayed(Duration(milliseconds: 1));

    // Call the delayed function
    delayedFunction();
  }
}
