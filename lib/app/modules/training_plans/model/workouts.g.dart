// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutsAdapter extends TypeAdapter<Workouts> {
  @override
  final int typeId = 0;

  @override
  Workouts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workouts(
      dateStart: fields[0] as DateTime,
      dateEnd: fields[1] as DateTime,
      description: fields[2] as String,
      trains: (fields[3] as List).cast<Train>(),
    );
  }

  @override
  void write(BinaryWriter writer, Workouts obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dateStart)
      ..writeByte(1)
      ..write(obj.dateEnd)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.trains);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TrainAdapter extends TypeAdapter<Train> {
  @override
  final int typeId = 3;

  @override
  Train read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Train(
      nameWorkout: fields[0] as String,
      repetitionWeight: (fields[2] as List).cast<int>(),
      weightEquipment: (fields[3] as List).cast<double>(),
      setOfExercises: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Train obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nameWorkout)
      ..writeByte(2)
      ..write(obj.repetitionWeight)
      ..writeByte(3)
      ..write(obj.weightEquipment)
      ..writeByte(4)
      ..write(obj.setOfExercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
