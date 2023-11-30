import 'package:budgetbee/model/usermodel.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveSetup {
  static Future<void> initHive() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    try {
      if (!Hive.isBoxOpen("user_db")) {
        await Hive.openBox<UserModel>("user_db");
      }
    } catch (e) {
      // Handle the exception, if necessary
      print('Error opening Hive box: $e');
    }
  }
}
