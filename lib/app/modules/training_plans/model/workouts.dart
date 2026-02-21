import 'package:hive_flutter/hive_flutter.dart';
part 'workouts.g.dart';

@HiveType(typeId: 0)
class Workouts extends HiveObject {
  @HiveField(0)
  final DateTime dateStart;

  @HiveField(1)
  final DateTime dateEnd;

  @HiveField(2)
  final String description;

  @HiveField(3)
  List<Train> trains;
  Workouts(
      {required this.dateStart,
      required this.dateEnd,
      required this.description,
      required this.trains});

  Map<String, dynamic> toMap() => {
        'dateStart': dateStart,
        'dateEnd': dateEnd,
        'description': description,
        'trains': trains,
      };

  factory Workouts.fromMap(Map<String, dynamic> map) => Workouts(
        dateStart: map['dateStart'] as DateTime,
        dateEnd: map['dateEnd'] as DateTime,
        description: map['description'] as String,
        trains: map['trains'] as List<Train>,
      );
}

@HiveType(typeId: 3)
class Train {
  @HiveField(0)
  String nameWorkout; //наименование упражнения

  @HiveField(2)
  List<int> repetitionWeight;

  @HiveField(3)
  List<double> weightEquipment;

  @HiveField(4)
  int setOfExercises; //

  Train(
      {required this.nameWorkout,
      required this.repetitionWeight,
      required this.weightEquipment,
      required this.setOfExercises});

  Map<String, dynamic> toMap() {
    return {
      'nameWorkout': nameWorkout,
      'repetitionWeight': repetitionWeight,
      'weightEquipment': weightEquipment,
      'setOfExercises': setOfExercises,
    };
  }

  factory Train.fromMap(Map<String, dynamic> map) {
    return Train(
      nameWorkout: map['nameWorkout'] as String,
      repetitionWeight: map['repetitionWeight'] as List<int>,
      weightEquipment: map['weightEquipment'] as List<double>,
      setOfExercises: map['setOfExercises'] as int,
    );
  }
}
