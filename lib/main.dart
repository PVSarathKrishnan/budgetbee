import 'package:budgetbee/model/addtransactionmodel.dart';
import 'package:budgetbee/model/usermodel.dart';
import 'package:budgetbee/screens/home_page.dart';
import 'package:budgetbee/screens/homescreen.dart';
import 'package:budgetbee/screens/income_only.dart';
import 'package:budgetbee/screens/splashscreen.dart';
import 'package:budgetbee/screens/transactionmainpage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

const SAVE_KEY_NAME = "userLoggedIn";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  if (!Hive.isAdapterRegistered(AddTransactionModelAdapter().typeId)) {
    Hive.registerAdapter(AddTransactionModelAdapter());
  }

  await Hive.openBox<AddTransactionModel>("transaction_db");
  await Hive.openBox<UserModel>("user_db");
  await Hive.openBox("money");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0XFF9486F7),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Color(0XFF9486F7)),
            centerTitle: true),
      ),
      title: 'Budget Bee',
      home: SplashScreen(),
      // home: HomePage(),
    );
  }
}
