// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'category_model.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class CategoryModalAdapter extends TypeAdapter<CategoryModal> {
//   @override
//   final int typeId = 2;

//   @override
//   CategoryModal read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return CategoryModal(
//       id: fields[0] as int,
//       category: fields[1] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, CategoryModal obj) {
//     writer
//       ..writeByte(2)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.category);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CategoryModalAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
