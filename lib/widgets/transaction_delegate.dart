import 'package:flutter/material.dart';

class TransactionDelegate extends SearchDelegate<void> {
  final List<Map<dynamic, dynamic>> data;

  TransactionDelegate(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      // Handle empty query scenario
      return Center(
        child: Text('Enter a search term'),
      );
    }

    final List<Map<dynamic, dynamic>> searchResults = data
        .where((data) =>
            data['note'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        Map dataAtIndex = searchResults[index];
        return buildTransactionTile(dataAtIndex);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<dynamic, dynamic>> searchResults = data
        .where((data) =>
            data['note'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        Map dataAtIndex = searchResults[index];
        return buildTransactionTile(dataAtIndex);
      },
    );
  }

  Widget buildTransactionTile(Map data) {
    if (data['type'] == 'Income') {
      return ListTile(
        title: Text(data['note']),
        subtitle: Text(
          'Amount: ${data['amount']}, Date: ${data['date']}',
          // Add appropriate date formatting as needed
        ),
        onTap: () {
          // Implement onTap functionality for Income transactions
          // For example: navigate to a detailed view or perform an action
        },
      );
    } else {
      return ListTile(
        title: Text(data['note']),
        subtitle: Text(
          'Amount: ${data['amount']}, Date: ${data['date']}',
          // Add appropriate date formatting as needed
        ),
        onTap: () {
          // Implement onTap functionality for Expense transactions
          // For example: navigate to a detailed view or perform an action
        },
      );
    }
  }
}
