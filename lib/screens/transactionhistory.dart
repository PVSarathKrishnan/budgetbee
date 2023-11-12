import 'package:budgetbee/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDE00),
      appBar: AppBar(
        title: Text("TRANSACTION HISTORY"),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/Background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                // List tiles
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF00FF0A),               
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          leading: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '18/7/23\n',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0),fontSize: 16),
                                ),
                                TextSpan(
                                  text: '9 : 30 AM',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0),fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          title: Center(
                            child: Text("INCOME", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)))),
                          trailing: Text("7500", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20))),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFD5C0A),                
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListTile(
                          leading: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '18/8/23\n',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0),fontSize: 16),
                                ),
                                TextSpan(
                                  text: '8 : 30 PM',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0),fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          title: Center(
                            child: Text("EXPENSE", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)))),
                          trailing: Text("5000", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20))),
                      ),
                      // Add more ListTiles here as needed
                      SizedBox(height: 480,),
                      ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none
                              ),
                              title: Container(
                                width: 180,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                color: Colors.black
                                ),
                                child: Text("Reset Confirmation",style: GoogleFonts.poppins(
                                  fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                              content: Text("Are you sure you want to reset your transaction history?                      This action cannot be undone. Please confirm to proceed",
                              style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                                    
                                  },
                                  child: Text('Confirm',style: GoogleFonts.poppins(color: const Color.fromARGB(255, 255, 17, 0),fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('No',style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                ),
                              ],
                            );
                          },
                        );
                      },
              child: Text(
                "RESET",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
