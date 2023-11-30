import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({super.key});

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  List<String> items = [
    "Income1",
    "Income2",
    "Income3",
    "Income1",
    "Income2",
    "Income3",
    "Income1",
    "Income2",
    "Income3",
    "Income1",
    "Income2",
    "Income3"
  ];
  List<String> Date = [
    "Date 1",
    "Date 2",
    "Date 3",
    "Date 1",
    "Date 2",
    "Date 3",
    "Date 1",
    "Date 2",
    "Date 3",
    "Date 1",
    "Date 2",
    "Date 3",
  ];
  List<String> Amount = [
    "Amount 1",
    "Amount 2",
    "Amount 3",
    "Amount 1",
    "Amount 2",
    "Amount 3",
    "Amount 1",
    "Amount 2",
    "Amount 3",
    "Amount 1",
    "Amount 2",
    "Amount 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDE00),
      appBar: AppBar(
        title: Text("INCOME LIST"),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    right: 8,
                    left: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      trailing: Text(
                        Amount[index],
                        style: GoogleFonts.poppins(color: Colors.green),
                      ),
                      leading: Text(Date[index], style: GoogleFonts.poppins()),
                      title: Text(items[index], style: GoogleFonts.poppins()),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
