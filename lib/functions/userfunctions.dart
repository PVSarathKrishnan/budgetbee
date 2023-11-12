import 'package:budgetbee/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
Future<void> addUser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  final _id=await userDB.add(value);
  value.id = _id;
  userListNotifier.value.add(value);
  userListNotifier.notifyListeners();
}
