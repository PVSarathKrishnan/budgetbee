import 'package:budgetbee/controllers/db_helper.dart';
import 'package:budgetbee/style/text_button_theme.dart';
import 'package:budgetbee/widgets/expense_tile.dart';
import 'package:budgetbee/widgets/income_tile.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  DbHelper dbHelper = DbHelper();
  bool sortAscending = true;
  late List<Map<dynamic, dynamic>> transactions = [];
  late List<Map<dynamic, dynamic>> allTransactions = [];
  String currentFilter = 'FILTER';
  String selectedDuration = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<dynamic, dynamic>> data = await dbHelper.fetchTransactions();
    setState(() {
      transactions = data;
      allTransactions = List.from(data); // Store all transactions initially
    });
  }

  void filterTransactionsByDuration(String duration) {
    DateTime now = DateTime.now();
    DateTime filterDate = DateTime.now();

    if (duration == 'past_24_hours') {
      filterDate = now.subtract(Duration(hours: 24));
      currentFilter = 'Past 24 hours'; // Update the current filter text
    } else if (duration == 'past_1_week') {
      filterDate = now.subtract(Duration(days: 7));
      currentFilter = 'Past 1 week'; // Update the current filter text
    } else if (duration == 'past_1_month') {
      filterDate = now.subtract(Duration(days: 30));
      currentFilter = 'Past 1 month'; // Update the current filter text
    } else if (duration == 'past_3_month') {
      filterDate = now.subtract(Duration(days: 90));
      currentFilter = 'Past 3 months'; // Update the current filter text
    } else if (duration == 'past_6_month') {
      filterDate = now.subtract(Duration(days: 180));
      currentFilter = 'Past 6 months'; // Update the current filter text
    } else if (duration == 'past_1_year') {
      filterDate = now.subtract(Duration(days: 365));
      currentFilter = 'Past 1 year'; // Update the current filter text
    }

    List<Map<dynamic, dynamic>> filteredTransactions =
        allTransactions.where((transaction) {
      DateTime transactionDate =
          transaction['date']; // Assuming 'date' is already DateTime type
      return transactionDate.isAfter(filterDate);
    }).toList();

    setState(() {
      transactions = filteredTransactions;
    });
  }

  void filterTransactions(String query) {
    if (query.isNotEmpty) {
      List<Map<dynamic, dynamic>> filteredTransactions = transactions
          .where((transaction) => transaction['note']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      setState(() {
        transactions = filteredTransactions;
      });
    } else {
      filterTransactionsByDuration(
          selectedDuration); // Replace '' with the variable representing the currently selected duration
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentFilter, style: text_theme_h()),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color(0XFF9486F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_alt),
            onSelected: (String value) {
              filterTransactionsByDuration(value);
              selectedDuration = value;
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'past_24_hours',
                child: Text(
                  'Past 24 hours',
                  style: text_theme(),
                ),
              ),
              PopupMenuItem<String>(
                value: 'past_1_week',
                child: Text(
                  'Past 1 week',
                  style: text_theme(),
                ),
              ),
              PopupMenuItem<String>(
                value: 'past_1_month',
                child: Text(
                  'Past 1 month',
                  style: text_theme(),
                ),
              ),
              PopupMenuItem<String>(
                value: 'past_3_month',
                child: Text(
                  'Past 3 months',
                  style: text_theme(),
                ),
              ),
              PopupMenuItem<String>(
                value: 'past_6_month',
                child: Text(
                  'Past 6 months',
                  style: text_theme(),
                ),
              ),
              PopupMenuItem<String>(
                value: 'past_1_year',
                child: Text(
                  'Past 1 year',
                  style: text_theme(),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      width: 300,
                      child: TextField(
                        style: text_theme_color_size(
                            Colors.black.withOpacity(.8), 18),
                        decoration: InputDecoration(
                          labelText: 'Search by note',
                          labelStyle:
                              text_theme_color(Colors.black.withOpacity(.7)),
                          prefixIcon:
                              Icon(Icons.search, color: Color(0XFF9486F7)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0XFF9486F7), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Color(0XFFD1CEFF),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (query) {
                          filterTransactions(query);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0XFF9486F7).withOpacity(.4),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          sortAscending = !sortAscending;
                        });
                      },
                      icon: Icon(Icons.swap_vert),
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //         horizontal: 16, vertical: 4), // Adjust padding as needed
            //     decoration: BoxDecoration(
            //       color: Colors.grey[300], // Set your desired background color
            //       borderRadius: BorderRadius.circular(8), // Set border radius
            //     ),
            //     child: Text(
            //       currentFilter,
            //       style: TextStyle(fontSize: 12), // Customize the style as needed
            //     ),
            //   ),
            // ),
            if (transactions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Map dataAtIndex = sortAscending
                      ? transactions[index]
                      : transactions[transactions.length - index - 1];
                  if (dataAtIndex['type'] == "Income") {
                    return IncomeTile(
                      value: dataAtIndex['amount'],
                      note: dataAtIndex['note'],
                      date: dataAtIndex['date'],
                    );
                  } else {
                    return ExpenseTile(
                      value: dataAtIndex['amount'],
                      note: dataAtIndex['note'],
                      date: dataAtIndex['date'],
                    );
                  }
                },
              ),
            if (transactions.isEmpty)
              Center(
                child: Text(
                  'No transactions found',
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
