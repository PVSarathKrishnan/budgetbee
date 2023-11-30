import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

const SAVE_KEY_NAME = "userLoggedIn";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox<UserModel>("user_db");

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Color(0xFFDE00))),
      ),
      
      title: 'Budget Bee',
      home: SplashScreen(),
    );
  }
}
