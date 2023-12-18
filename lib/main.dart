import 'package:budgetbee/db/category_functions.dart';
import 'package:budgetbee/model/category_model.dart';
import 'package:budgetbee/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and setup directories
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(CategoryModelAdapter());

  // Open necessary Hive boxes before using CategoryFunctions
  await Hive.openBox('money');
  await Hive.openBox('categories');
  await Hive.openBox("expenseCategoryBox");
  await Hive.openBox("incomeCategoryBox");

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
      home: SplashScreen(), // Change home to SplashScreen
    );
  }
}
