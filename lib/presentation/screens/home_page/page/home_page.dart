import 'dart:async';
import 'dart:math';
import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/db/repositories/budget_calculator_functions.dart';
import 'package:budgetbee/db/models/budget_calculator.dart';
import 'package:budgetbee/db/models/transaction_modal.dart';
import 'package:budgetbee/presentation/screens/add_transaction_screen/page/add_transaction.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/balance_card.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/budget_plan_heading.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/drawer_widget_icons.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/empty_data_piechart.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/empty_data_widget.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/expense_tracker_heading.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/profile_view.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/ratio_graph.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/recent_transaction_heading.dart';
import 'package:budgetbee/presentation/screens/home_page/widget/homepage_widgets/warning_widget.dart';
import 'package:budgetbee/presentation/screens/reminder_page/page/reminder_screen.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:budgetbee/presentation/common_widgets/expense_tile.dart';
import 'package:budgetbee/presentation/common_widgets/income_tile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
              SettingsIcon(),
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
              AboutUsIcon(),
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
              GetHelpIcon(),
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
                        child: EmptyDataWidget(preferences: preferences),
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
                          child: BalanceCard(
                              totalBalance: totalBalance,
                              totalIncome: totalIncome,
                              totalExpense: totalExpense),
                        ),
                        ExpenseHeading(
                            totalBalance: totalBalance,
                            totalIncome: totalIncome,
                            totalExpense: totalExpense),
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
                                    return EmptyDataPieChart();
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
                        RecentTransactionHeading(),
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
                        BudgetHeading(),
                        RatioGraphWidget(
                            expenseToIncomeRatio: expenseToIncomeRatio),
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
          child: ProfileViewWidget(preferences: preferences),
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

  WarningTextWidget showWarning(BuildContext context) {
    return WarningTextWidget();
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
