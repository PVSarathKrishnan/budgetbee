import 'package:budgetbee/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDE00), // Setting background color
      // appBar: AppBar(
      //   title: Text("ABOUT"), // Setting the app bar title
      //   iconTheme: IconThemeData(color: Colors.white),
      //   centerTitle: true, // Centering the app bar title
      //   backgroundColor:
      //       Color.fromARGB(255, 0, 0, 0), // Setting app bar background color
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(30)), // Setting app bar shape
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'lib/assets/Background.png'), // Setting the background image
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 170),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15), // Setting border radius
                    color:
                        Colors.white.withOpacity(.7), // Setting container color
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 11, left: 11, right: 11),
                    child: Text(
                      "BudgetBee is your go-to solution for effortless financial management. Our intuitive platform equips you with the tools and insights needed to take charge of your finances. From smart budgeting to comprehensive analytics, BudgetBee paves the way towards achieving your financial aspirations, hassle-free.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black.withOpacity(.65),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 180,
              ), // Providing space
              Column(
                children: [
                  Container(
                    width: 130,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0)
                          .withOpacity(.8), // Setting container color
                      borderRadius:
                          BorderRadius.circular(30), // Setting border radius
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "VERSION 1.0.0", // Displaying version number
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(.3), // Setting container color
                      borderRadius:
                          BorderRadius.circular(12), // Setting border radius
                    ),
                    child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back),iconSize: 25,),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
