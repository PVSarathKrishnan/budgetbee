

import 'package:budgetbee/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<UserModel>> userListNotifier=ValueNotifier([]);

//to add users
Future<void> addUser(UserModel value) async{
  final userDB = await Hive.openBox<UserModel>('user_db');
  final _id=await userDB.add(value);
  value.id=_id;
  userListNotifier.value.add(value);
  userListNotifier.notifyListeners();
}
