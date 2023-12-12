// import 'package:hive_flutter/hive_flutter.dart';
// part 'category_model.g.dart';

// @HiveType(typeId: 2)
// class CategoryModal {
//   @HiveField(0)
//   final int id;

//   @HiveField(1)
//   final String category;

//   CategoryModal({required this.id, required this.category});
// }

// Future<void> addCat(CategoryModal value) async {
//   final hospDB = await Hive.openBox<CategoryModal>('cat_db');
//   final id = await hospDB.add(value);
//   final data = hospDB.get(id);
//   await hospDB.put(id, CategoryModal(category: data!.category, id: id));
  
// }
