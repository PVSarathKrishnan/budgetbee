import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search by note',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (query) {
          // You can handle the search query here
          // Call a function in the parent widget to filter the data
          // For example:
          // Provider.of<TransactionHistoryScreen>(context, listen: false)
          //   .filterTransactions(query);
        },
      ),
    );
  }
}
