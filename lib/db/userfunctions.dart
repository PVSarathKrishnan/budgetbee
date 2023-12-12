import 'package:budgetbee/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
  String userEmail = "";
  UserModel? currentUser;
Future<void> addUser(UserModel value) async {
  final userBox = await Hive.openBox<UserModel>("user_db");
  final id = await userBox.add(value);
  final data = userBox.get(id);
  await userBox.put(
      id,
      UserModel(
          id: data!.id,
          name: data.name,
          email: data.email,
          password: data.password,
          photo: data.photo));
}

Future<void> editProfile(int id, String updatedUserName, String updatedEmailId,
    String updatedPhoto) async {
  final userBox = await Hive.openBox<UserModel>('user_db');
  final existingUser = userBox.values.firstWhere((value) => value.id == id);
  existingUser.name = updatedUserName;
  existingUser.email = updatedEmailId;
  existingUser.photo = updatedPhoto;

  await userBox.put(id, existingUser);
}
  // Future<void> getUser() async {
  //   // retrieving the current user email from shared preference
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   // if the current user is null
  //   userEmail = prefs.getString("currentUser") ?? "";
  //   // checking the user in db using the same email
  //   final userBox = await Hive.openBox<UserModel>("user_db");
  //   currentUser = userBox.values.firstWhere((user) => user.email == userEmail);
  //   // setState(() {}); error!!
  // }
  
