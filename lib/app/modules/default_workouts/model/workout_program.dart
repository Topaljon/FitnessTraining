class WorkoutProgram {
  DateTime dateStart;
  DateTime dateEnd;
  String description;
  List<Workout> trains;

  WorkoutProgram({
    required this.dateStart,
    required this.dateEnd,
    required this.description,
    required this.trains,
  });

  factory WorkoutProgram.fromJson(Map<String, dynamic> json) =>
      WorkoutProgram(
        dateStart: json['dateStart']==0? DateTime.now():DateTime.now(),
        dateEnd: json['dateEnd'] ==0 ? DateTime.now().add(Duration(days: 60)): DateTime.now().add(Duration(days: 60)),
        description: json['description'],
        trains: (json['trains'] as List)
            .map((e) => Workout.fromJson(e))
            .toList(),
      );
}

class Workout {
  String nameWorkout;
  List<int> repetitionWeight;
  List<double> weightEquipment;
  int setOfExercises;

  Workout({
    required this.nameWorkout,
    required this.repetitionWeight,
    required this.weightEquipment,
    required this.setOfExercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    nameWorkout: json['nameWorkout'],
    repetitionWeight:
    List<int>.from(json['repetitionWeight'].map((e) => e)),
    weightEquipment:
    List<double>.from(json['weightEquipment'].map((e) => e)),
    setOfExercises: json['setOfExercises'],
  );
}