import 'package:budgetbee/screens/welcomescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 60,),
                Container(
                  height: 190,
                  width: 200,
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Container(
                        height: 140,
                        width: 140,
                        child: Image(image: AssetImage("lib/assets/Logo.png"))),
                      SizedBox(height: 10,),
                    ],
                  ),
                  ),
                Container(
                  width: 280,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("LOGIN",style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w400),),
                      SizedBox(height: 30),
                        Text(
                          "We'd love to get to know you!",
                          style: GoogleFonts.comfortaa(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  labelText: "Enter your email id",
                                  labelStyle: GoogleFonts.poppins(),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(.7),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  labelText: "Enter your password",
                                  labelStyle: GoogleFonts.poppins(),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(.7),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),));
                            },
                            child: Text("LOGIN",style: GoogleFonts.poppins(color: const Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                            style: ButtonStyle(shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              backgroundColor: MaterialStatePropertyAll(
                                const Color.fromARGB(255, 0, 0, 0)
                                )
                                ),
                                ),
                      ]
                      )
                      )
                      ]
                      )
                      )
              ]
              )
              )
              ),
      )
            );
          
                    
 
 
  }
}