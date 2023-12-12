import 'package:flutter/material.dart';

class TransactionSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> transactions;

  TransactionSearch({required this.transactions});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> results = transactions
        .where((transaction) =>
            transaction['note'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final transaction = results[index];
        return ListTile(
          title: Text(transaction['note']),
          // Other details of the transaction
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> suggestions = transactions
        .where((transaction) =>
            transaction['note'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final transaction = suggestions[index];
        return ListTile(
          title: Text(transaction['note']),
          // Other details of the transaction
        );
      },
    );
  }
}
