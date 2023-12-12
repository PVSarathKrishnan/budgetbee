import 'package:budgetbee/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:budgetbee/screens/splashscreen.dart'; // Assuming you have these imports correctly configured
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Register Hive adapters and open boxes here
  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }
  await Hive.openBox<UserModel>('user_db');
  await Hive.openBox('money');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primaryColor: const Color(0XFF9486F7),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0XFF9486F7)),
          centerTitle: true,
        ),
      ),
      title: 'Budget Bee',
      home: SplashScreen(), // Change home to SplashScreen
    );
  }
}
