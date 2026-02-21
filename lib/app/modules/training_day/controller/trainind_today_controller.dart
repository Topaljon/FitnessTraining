import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/training_today.dart';

class TrainingTodayController extends GetxController {
  final String dbTrainingToday = 'trainingToDay';

  final Rx<TextEditingController> _updateRepetitionWeight =
      TextEditingController().obs;
  Rx<TextEditingController> get updateRepetitionWeight =>
      _updateRepetitionWeight;

  final Rx<TextEditingController> _updateWeightEquipment =
      TextEditingController().obs;
  Rx<TextEditingController> get updateWeightEquipment => _updateWeightEquipment;

  final List<TextEditingController?> _updateRepetitionWeightController =
      <TextEditingController?>[].obs;
  List<TextEditingController?> get updateRepetitionWeightController =>
      _updateRepetitionWeightController;

  final List<TextEditingController?> _updateWeightEquipmentController =
      <TextEditingController?>[].obs;
  List<TextEditingController?> get updateWeightEquipmentController =>
      _updateWeightEquipmentController;

  @override
  void onInit() {
    //getWorkout();
    //getNutrition();
    super.onInit();
  }

  getTrainingTodayByIndex(int indexObg) {
    final workoutsTodayBox = Hive.box(dbTrainingToday);
    //workoutsTodayBox.clear();
    return workoutsTodayBox.getAt(indexObg);
  }

  Future<void> updateTrainingToday(
      {required index, required trainingTodayField}) async {
    final workoutsTodayBox = Hive.box(dbTrainingToday);
    workoutsTodayBox.putAt(index, trainingTodayField);
  }

  Future<void> addTrainingToday(TrainingToday trainingToday) async {
    final trainingTodayBox = Hive.box(dbTrainingToday);
    await trainingTodayBox.add(trainingToday);
    //cleanFormWorkout();
  }

  Future<void> deleteTrainTodayByIndex(int index) async {
    final trainingTodayBox = Hive.box(dbTrainingToday);
    await trainingTodayBox.deleteAt(index);
  }

  void cleanRepetitionWeightController() async {
    updateRepetitionWeightController.clear();
  }

  void cleanWeightEquipmentController() async {
    updateWeightEquipmentController.clear();
  }

  updateRepetitionWeightByIndex(int index, TrainingToday repetitionWeight) {
    final trainingTodayBox = Hive.box(dbTrainingToday);
    trainingTodayBox.putAt(index, repetitionWeight);
  }

  updateWeightEquipmentByIndex(int index, TrainingToday weightEquipment) {
    final trainingTodayBox = Hive.box(dbTrainingToday);
    trainingTodayBox.putAt(index, weightEquipment);
  }
}
