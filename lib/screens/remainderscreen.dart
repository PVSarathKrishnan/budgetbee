import 'package:flutter/material.dart';

class remainderScreen extends StatefulWidget {
  const remainderScreen({super.key});

  @override
  State<remainderScreen> createState() => _remainderScreenState();
}

class _remainderScreenState extends State<remainderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFDE00),
        appBar: AppBar(
          title: Text("ADD REMAINDER"),
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
    );
  }
}