// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_today.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingTodayAdapter extends TypeAdapter<TrainingToday> {
  @override
  final int typeId = 4;

  @override
  TrainingToday read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingToday(
      id: fields[0] as String,
      trainingDay: fields[1] as int,
      trainToday: (fields[2] as List).cast<Train>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrainingToday obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.trainingDay)
      ..writeByte(2)
      ..write(obj.trainToday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingTodayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
