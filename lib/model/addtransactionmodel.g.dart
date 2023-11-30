// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addtransactionmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddTransactionModelAdapter extends TypeAdapter<AddTransactionModel> {
  @override
  final int typeId = 2;

  @override
  AddTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddTransactionModel(
      amount: fields[1] as int?,
      description: fields[2] as String?,
      date: fields[3] as DateTime,
      id: fields[0] as int?,
      type: fields[4] as bool?,
      total: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AddTransactionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
