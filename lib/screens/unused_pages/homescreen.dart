// import 'dart:io';
// import 'package:budgetbee/db/transactionfunction.dart';
// import 'package:budgetbee/model/usermodel.dart';
// import 'package:budgetbee/screens/aboutscreen.dart';
// import 'package:budgetbee/screens/add_transaction.dart';
// // import 'package:budgetbee/screens/editprofilescreen.dart';
// import 'package:budgetbee/screens/expense_only.dart';
// import 'package:budgetbee/screens/income_only.dart';
// import 'package:budgetbee/screens/loginscreen.dart';
// import 'package:budgetbee/screens/unused_pages/profilescreen.dart';
// import 'package:budgetbee/screens/unused_pages/transactionhistory.dart';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  

//   // double availableBalance = 0;
//   String userEmail = "";
//   UserModel? currentUser;
//   @override
//   void initState() {
//     super.initState();
//     // call the function to get the user
//     getUser();
//   }

//   Future<void> getUser() async {
//     // retrieving the current user email from shared preference
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     // if the current user is null
//     userEmail = prefs.getString("currentUser") ?? "";
//     // checking the user in db using the same email
//     final userBox = await Hive.openBox<UserModel>("user_db");
//     currentUser = userBox.values.firstWhere((user) => user.email == userEmail);
//     setState(() {});
//     getTransaction();
//   }

//   getTransaction() async {
//     final transactionBox = await Hive.openBox("trasan");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFFFDE00),
//         appBar: AppBar(
//           title: Text("HOME"),
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 0, 0, 0),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         ),
//         body: currentUser != null
//             ? Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                   image: AssetImage('lib/assets/Background.png'),
//                 )),
//                 child: SingleChildScrollView(
//                     child: Center(
//                   child: Column(children: [
//                     // Circle Avatar for the user's profile
//                     SizedBox(height: 35),
//                     CircleAvatar(
//                       // foregroundImage: AssetImage('lib/assets/profile.png'),
//                       backgroundImage: FileImage(File(currentUser!.photo)),
//                       radius: 60,
//                     ),
//                     SizedBox(height: 25),
//                     // Container for user details
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(.53),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       height: 60,
//                       width: 300,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ListTile(
//                             leading: Text(""),
//                             title: Center(
//                               child: Text(
//                                 "${currentUser!.name}",
//                                 style: GoogleFonts.poppins(
//                                   color:
//                                       const Color.fromARGB(255, 255, 255, 255),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                             trailing: IconButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ProfileScreen(),
//                                   ),
//                                 );
//                               },
//                               icon: Icon(
//                                 Icons.person_pin_sharp,
//                                 color: Colors.white,
//                                 size: 30,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // Container for available balance
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(.53),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       height: 150,
//                       width: 300,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 10),
//                           Text(
//                             "Available Balance",
//                             style: GoogleFonts.poppins(
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 25,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             "₹${0}",
//                             style: GoogleFonts.poppins(
//                               color: const Color.fromARGB(255, 255, 255, 255),
//                               fontWeight: FontWeight.bold,
//                               fontSize: 55,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     // Button for transaction history
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TransactionHistoryScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         "TRANSACTION HISTORY",
//                         style: GoogleFonts.poppins(
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         backgroundColor: MaterialStateProperty.all(
//                           const Color.fromARGB(255, 0, 0, 0),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     // Button for adding transaction
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AddTransaction(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         "ADD TRANSACTION",
//                         style: GoogleFonts.poppins(
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         backgroundColor: MaterialStateProperty.all(
//                           const Color.fromARGB(255, 0, 0, 0),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     // Containers for Total Income and Total Expense
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: 160,
//                           height: 160,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: Color.fromARGB(255, 255, 255, 255)
//                                 .withOpacity(.53),
//                           ),
//                           child: Column(
//                             children: [
//                               // Button for Total Income
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => IncomeList(),
//                                       ));
//                                 },
//                                 child: Text(
//                                   "Total Income",
//                                   style: GoogleFonts.poppins(
//                                     color: const Color.fromARGB(
//                                         255, 255, 255, 255),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 style: ButtonStyle(
//                                   foregroundColor: MaterialStateProperty.all(
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ),
//                                   backgroundColor: MaterialStateProperty.all(
//                                     Colors.black,
//                                   ),
//                                   shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 "₹7500",
//                                 style: GoogleFonts.poppins(
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 40,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: 20),
//                         Container(
//                           width: 160,
//                           height: 160,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: const Color.fromARGB(255, 255, 255, 255)
//                                 .withOpacity(.53),
//                           ),
//                           child: Column(
//                             children: [
//                               // Button for Total Expense
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ExpenseList(),
//                                       ));
//                                 },
//                                 child: Text(
//                                   "Total Expense",
//                                   style: GoogleFonts.poppins(
//                                     color: const Color.fromARGB(
//                                         255, 255, 255, 255),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 style: ButtonStyle(
//                                   foregroundColor: MaterialStateProperty.all(
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ),
//                                   backgroundColor: MaterialStateProperty.all(
//                                     Colors.black,
//                                   ),
//                                   shape: MaterialStateProperty.all(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 "₹5000",
//                                 style: GoogleFonts.poppins(
//                                   color: Color.fromARGB(255, 0, 0, 0),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 40,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10),
//                     // Button for About
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AboutScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         "About",
//                         style: GoogleFonts.poppins(
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         backgroundColor: MaterialStateProperty.all(
//                           const Color.fromARGB(255, 0, 0, 0),
//                         ),
//                       ),
//                     ),
//                     // Container for the logo
//                     Container(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 45,
//                             width: 45,
//                             child: Image(
//                               image: AssetImage("lib/assets/Logo.png"),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//                 )),
//               )
//             : Center(
//                 child: Center(
//                     child: Column(
//                   children: [
//                     SizedBox(
//                       height: 200,
//                     ),
//                     Text("User Not Logged in "),
//                     TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginScreen()));
//                         },
//                         child: Text("Proceed To Login"))
//                   ],
//                 )),
//               ));
//   }
// }
