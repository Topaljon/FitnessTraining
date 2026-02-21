import 'package:hive_flutter/hive_flutter.dart';

import '../../training_plans/model/workouts.dart';
part 'training_today.g.dart';

@HiveType(typeId: 4)
class TrainingToday extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int trainingDay;

  @HiveField(2)
  List<Train> trainToday;

  TrainingToday(
      {required this.id, required this.trainingDay, required this.trainToday});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trainingDay': trainingDay,
      'trainToday': trainToday,
    };
  }

  factory TrainingToday.fromMap(Map<String, dynamic> map) {
    return TrainingToday(
      id: map['id'] as String,
      trainingDay: map['trainingDay'] as int,
      trainToday: map['trainToday'] as List<Train>,
    );
  }
}
