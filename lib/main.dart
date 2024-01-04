import 'package:budgetbee/db/models/budget_calculator.dart';
import 'package:budgetbee/db/models/reminder_model.dart';

import 'package:budgetbee/db/repositories/category_functions.dart';
import 'package:budgetbee/db/models/category_model.dart';

import 'package:budgetbee/presentation/screens/splash_screen/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and setup directories
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ReminderAdapter());
  Hive.registerAdapter(
      BudgetCalculatorAdapter()); // Register the generated adapter
  // Open necessary Hive boxes
  await Hive.openBox('money');
  await Hive.openBox('categories');
  await Hive.openBox("expenseCategoryBox");
  await Hive.openBox("incomeCategoryBox");
  await Hive.openBox<BudgetCalculator>('budget_calculators');
  await Hive.openBox('budgetCalculatorBox');
  // Open remindersBox with the correct type
  await Hive.openBox<Reminder>('remindersbox');
  // Create an instance of CategoryFunctions and setup categories
  final categoryFunctions = CategoryFunctions();
  await categoryFunctions.setupCategories();

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
        home: SplashScreen());
  }
}
