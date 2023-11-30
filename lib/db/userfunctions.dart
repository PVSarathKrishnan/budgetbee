import 'package:budgetbee/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);

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
// Future<void> getUser() async{
//   final userBox = await Hive.openBox<UserModel>('user_db');
//   userListNotifier.value.clear();
//   userListNotifier.value.addAll(userBox.values);
//   userListNotifier.notifyListeners();
// }