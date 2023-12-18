import 'package:hive/hive.dart';

part 'category_model.g.dart'; // Generated file

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String type;

  CategoryModel({required this.name, required this.type});
}
