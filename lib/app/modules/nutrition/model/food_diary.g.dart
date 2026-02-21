// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_diary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodDiaryAdapter extends TypeAdapter<FoodDiary> {
  @override
  final int typeId = 2;

  @override
  FoodDiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodDiary(
      dateStart: fields[0] as DateTime,
      dateEnd: fields[1] as DateTime,
      descriptionFood: fields[2] as String,
      foodDiary: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, FoodDiary obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateStart)
      ..writeByte(1)
      ..write(obj.dateEnd)
      ..writeByte(2)
      ..write(obj.descriptionFood)
      ..writeByte(3)
      ..write(obj.foodDiary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodDiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
