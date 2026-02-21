import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../training_day/model/training_today.dart' show TrainingToday;

class WorkoutControllers extends GetxController {
  int frameColor = 0;
  final String dbWorkout = 'workout';

  funcFrame() {
    update();
  }

  updateWorkoutByIndex(int index, TrainingToday workoutByIndex) {
    final trainingTodayBox = Hive.box(dbWorkout);
    trainingTodayBox.putAt(index, workoutByIndex);
  }
}
