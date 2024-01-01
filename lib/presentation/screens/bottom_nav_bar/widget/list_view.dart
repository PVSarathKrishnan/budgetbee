
import 'package:budgetbee/presentation/common_widgets/expense_tile.dart';
import 'package:budgetbee/presentation/common_widgets/income_tile.dart';
import 'package:flutter/material.dart';

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    super.key,
    required this.transactions,
    required this.sortAscending,
  });

  final List<Map> transactions;
  final bool sortAscending;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}