import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutCard extends StatelessWidget {
  final train;
  const WorkoutCard({super.key, required this.train});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(train.nameWorkout,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("${'translates.approaches'.tr} ${train.setOfExercises}"),
            Text("${'translates.approaches'.tr} ${train.repetitionWeight.join(', ')}"),
            Text("${'translates.weight'.tr} ${train.weightEquipment.join(', ')} ${'translates.kilogram'.tr}"),
          ],
        ),
      ),
    );
  }
}