import 'dart:math';
import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/db/models/transaction_modal.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:budgetbee/presentation/common_widgets/expense_income_widget.dart';
import 'package:budgetbee/presentation/common_widgets/show_description.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class StatPage extends StatefulWidget {
  const StatPage({
    Key? key,
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
  }) : super(key: key);

  final int totalBalance;
  final int totalIncome;
  final int totalExpense;

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  late int totalBalance;
  late int totalIncome;
  late int totalExpense;
  double expenseToIncomeRatio = 0;
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    totalBalance = widget.totalBalance;
    totalIncome = widget.totalIncome;
    totalExpense = widget.totalExpense;
    fetchData(); // Fetch data when the page is initialized
  }

  void fetchData() async {
    try {
      List<TransactionModal> transactionData =
          await dbHelper.fetchTransactionData();
      getTotalBalance(transactionData);
      setState(() {}); // Update the state with fetched data
    } catch (e) {
      // Handle exception/error
    }
  }

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

    List<FlSpot> dataSet = dayWiseExpenses.entries.map((entry) {
      return FlSpot(entry.key.day.toDouble(), entry.value.toDouble());
    }).toList();

    dataSet.sort((a, b) => a.x.compareTo(b.x));

    return dataSet;
  }

  List<FlSpot> getPlotPointsIncome(List<TransactionModal> entireData) {
    Map<DateTime, int> dayWiseIncomes = {};

    entireData.forEach((data) {
      if (data.type == "Income") {
        DateTime dateKey =
            DateTime(data.date.year, data.date.month, data.date.day);
        if (dayWiseIncomes.containsKey(dateKey)) {
          dayWiseIncomes[dateKey] = dayWiseIncomes[dateKey]! + data.amount;
        } else {
          dayWiseIncomes[dateKey] = data.amount;
        }
      }
    });

    List<FlSpot> dataSet = dayWiseIncomes.entries.map((entry) {
      return FlSpot(entry.key.day.toDouble(), entry.value.toDouble());
    }).toList();

    dataSet.sort((a, b) => a.x.compareTo(b.x));

    return dataSet;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ANALYTICS', style: text_theme_h()),
        centerTitle: true,
        backgroundColor: Color(0XFF9486F7),
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<TransactionModal>>(
          future: dbHelper.fetchTransactionData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Unexpected Error"),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text("No Data Available"),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 8, bottom: 8, top: 8),
                      child: Text(
                        "Expense to income ratio",
                        style: text_theme_h(),
                      ),
                    ),
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
                              expenseToIncomeRatio: expenseToIncomeRatio)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 8, bottom: 8, top: 8),
                      child: Text(
                        "Expense Pi Chart - ${DateFormat('MMMM').format(DateTime.now())}",
                        style: text_theme_h(),
                      ),
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
                                child: PieChart(
                                  PieChartData(
                                    sections: pieSnapshot.data!,
                                    // Add more configurations for the PieChart as needed
                                  ),
                                ),
                              );
                            } else {
                              return Center(child: Text('No data available'));
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 8, bottom: 8, top: 8),
                      child: Text(
                        "Income Pi Chart - ${DateFormat('MMMM').format(DateTime.now())}",
                        style: text_theme_h(),
                      ),
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
                          future: getDataForPieChartIncome(snapshot.data!),
                          builder: (context, pieSnapshot) {
                            if (pieSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (pieSnapshot.hasError) {
                              return Center(child: Text('Error loading data'));
                            } else if (pieSnapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: PieChart(
                                  PieChartData(
                                    sections: pieSnapshot.data!,
                                    // Add more configurations for the PieChart as needed
                                  ),
                                ),
                              );
                            } else {
                              return Center(child: Text('No data available'));
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 8, bottom: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Expense Analysis - ${DateFormat('MMMM').format(DateTime.now())}",
                            style: text_theme_h(),
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return show_description(context: context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
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
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: getPlotPoints(snapshot.data!),
                              color: Color.fromARGB(255, 255, 0, 0),
                              // isCurved: true,
                              dotData: FlDotData(
                                show: true,
                              ),
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15, bottom: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Income Analysis - ${DateFormat('MMMM').format(DateTime.now())}",
                            style: text_theme_h(),
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return show_description(context: context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
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
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: getPlotPointsIncome(snapshot.data!),
                              color: Color.fromARGB(255, 0, 255, 13),
                              // isCurved: true,
                              dotData: FlDotData(
                                show: true,
                              ),
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
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
        titleStyle: text_theme_h(),
        color: getRandomColor(),
      );
    }).toList();

    return pieChartData;
  }

  Future<List<PieChartSectionData>> getDataForPieChartIncome(
      List<TransactionModal> transactionData) async {
    // Fetching expense data
    Map<String, double> expenseNoteAmountMap =
        await dbHelper.fetchIncomeNoteAmountMap();

    // Process the fetched map data to create PieChartSectionData list
    List<PieChartSectionData> pieChartData =
        expenseNoteAmountMap.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        titleStyle: text_theme_h(),
        color: getRandomColor(),
      );
    }).toList();

    return pieChartData;
  }

  Color getRandomColor() {
    Random random = Random();

    // List of banned colors (pure white, black, and shades of gray)
    List<int> bannedColors = [0, 255];

    // Generating random color components while avoiding banned colors
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    // Check if the color is too light or too dark
    if ((red < 100 && green < 100 && blue < 100) ||
        (red > 200 && green > 200 && blue > 200)) {
      return getRandomColor(); // Recursively generate another color
    }

    // Check if the color matches any banned color
    if (bannedColors.contains(red) ||
        bannedColors.contains(green) ||
        bannedColors.contains(blue)) {
      return getRandomColor(); // Recursively generate another color
    }

    return Color.fromARGB(255, red, green, blue);
  }
}
