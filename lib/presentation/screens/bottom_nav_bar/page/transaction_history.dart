import 'package:budgetbee/db/repositories/transaction_function.dart';
import 'package:budgetbee/presentation/screens/bottom_nav_bar/page/filter_page.dart';
import 'package:budgetbee/presentation/style/text_button_theme.dart';
import 'package:budgetbee/presentation/common_widgets/expense_tile.dart';
import 'package:budgetbee/presentation/common_widgets/income_tile.dart';
import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  bool sortAscending = true;
  DbHelper dbHelper = DbHelper();
  late List<Map<dynamic, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<dynamic, dynamic>> data = (await dbHelper.fetchTransactions());
    setState(() {
      transactions = data;
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
      fetchData(); // Reset to all transactions if the query is empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Color(0XFF9486F7),
        backgroundColor: Colors.white,
        displacement: 50,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await fetchData();
          setState(() {});
        },
        child: SingleChildScrollView(
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
                              borderSide: BorderSide(
                                  color: Color(0XFF9486F7), width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Color(0XFFD1CEFF),
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => FilterPage(),
                          ));
                        },
                        icon: Icon(Icons.filter_alt),
                      ),
                    ),
                  ],
                ),
              ),
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
      ),
    );
  }
}
