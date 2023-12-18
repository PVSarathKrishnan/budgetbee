// import 'package:budgetbee/screens/loginscreen.dart';
// import 'package:budgetbee/screens/signupscreen.dart';
// import 'package:budgetbee/style/text_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginOrSignupPage extends StatelessWidget {
//   const LoginOrSignupPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('lib/assets/Background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 60,
//               ),
//               Container(
//                 height: 190,
//                 width: 200,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                         height: 140,
//                         width: 140,
//                         child: Image(image: AssetImage("lib/assets/Logo.png"))),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                   width: 280,
//                   child: Column(
//                     children: [
//                       Text(
//                         "Welcome to BudgetBee,",
//                         style: GoogleFonts.pacifico(
//                           fontSize: 25,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "your partner in financial success. Easily manage your money and reach your goals effortlessly.",
//                         style: text_theme_h1(),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                         height: 80,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SignupScreen(),
//                               ));
//                         },
//                         child: Text("Sign up and start budgeting",
//                             style: text_theme()),
//                         style: ButtonStyle(
//                             shape: MaterialStatePropertyAll(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30))),
//                             backgroundColor: MaterialStatePropertyAll(
//                                 Color.fromARGB(255, 0, 0, 0))),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginScreen(),
//                               ));
//                         },
//                         child: Text("Already signed up ?  Log in ",
//                             style: text_theme()),
//                         style: ButtonStyle(
//                             shape: MaterialStatePropertyAll(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30))),
//                             backgroundColor: MaterialStatePropertyAll(
//                                 Color.fromARGB(255, 0, 0, 0))),
//                       ),
//                     ],
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
