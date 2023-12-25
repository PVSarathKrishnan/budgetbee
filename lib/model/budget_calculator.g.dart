// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_calculator.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetCalculatorAdapter extends TypeAdapter<BudgetCalculator> {
  @override
  final int typeId = 4;

  @override
  BudgetCalculator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BudgetCalculator(
      category: fields[0] as String,
      amountLimit: fields[1] as double,
      usedAmount: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BudgetCalculator obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.amountLimit)
      ..writeByte(2)
      ..write(obj.usedAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetCalculatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
