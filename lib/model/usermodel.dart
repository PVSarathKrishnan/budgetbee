import 'package:hive/hive.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  @HiveField(3)
  String? password;

  UserModel({required this.name, required this.email, required this.password});
}
