import 'dart:math';

import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/model/transaction_modal.dart';
import 'package:budgetbee/screens/add_transaction.dart';
import 'package:budgetbee/style/text_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key});

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  DbHelper dbHelper = DbHelper();

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
                        "Expense Pi Chart - ${DateFormat('MMMM').format(selectedDate)}",
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
                        "Income Pi Chart - ${DateFormat('MMMM').format(selectedDate)}",
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
                            "Expense Analysis - ${DateFormat('MMMM').format(selectedDate)}",
                            style: text_theme_h(),
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return showDescription(context);
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
                            "Income Analysis - ${DateFormat('MMMM').format(selectedDate)}",
                            style: text_theme_h(),
                          ),
                          IconButton(
                            icon: Icon(Icons.help_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return showDescription(context);
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

  AlertDialog showDescription(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Change the background color here
      title: Text('Chart Information',
          style: text_theme()), // Set the text style for the title
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Horizontal Axis: Date',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    text_theme().color), // Set the text style for the content
          ),
          Text(
            'Represents the dates in the chart.',
            style: text_theme(), // Set the text style for the content
          ),
          SizedBox(height: 10),
          Text(
            'Vertical Axis: Amount',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                    text_theme().color), // Set the text style for the content
          ),
          Text(
            'Denotes the amount of transaction',
            style: text_theme(), // Set the text style for the content
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close',
              style: text_theme()), // Set the text style for the action
        ),
      ],
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
        titleStyle: text_theme(),
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
        titleStyle: text_theme(),
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
