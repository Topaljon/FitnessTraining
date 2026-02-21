import 'dart:convert';
import 'package:FitnTrain/app/modules/nutrition/model/food_diary.dart' show FoodDiary;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../default_workouts/model/workout_program.dart' show WorkoutProgram;
import '../../training_plans/model/workouts.dart';

class HomeController extends GetxController {
  final String dbWorkout = 'workout';
  final RxString dbNutrition = 'nutrition'.obs;

  final RxList _contact = [].obs;
  RxList get contact => _contact; //<---------------------надо доделать

  final RxList<String> _dietList = <String>[].obs;
  RxList<String> get dietList => _dietList;

  final Rx<TextEditingController> _addTrain = TextEditingController().obs;
  Rx<TextEditingController> get addTrain => _addTrain;

  final Rx<TextEditingController> _addWorkoutApproaches =
      TextEditingController().obs;
  Rx<TextEditingController> get addWorkoutApproaches => _addWorkoutApproaches;

  final Rx<TextEditingController> _addWorkoutRepetitions =
      TextEditingController().obs;
  Rx<TextEditingController> get addWorkoutRepetitions => _addWorkoutRepetitions;
  final Rx<TextEditingController> _addDescriptionWorkout =
      TextEditingController().obs;
  Rx<TextEditingController> get addDescriptionWorkout => _addDescriptionWorkout;

  final Rx<TextEditingController> _addPitanie = TextEditingController().obs;
  Rx<TextEditingController> get addPitanie => _addPitanie;
  final Rx<TextEditingController> _addDescriptionPitanie =
      TextEditingController().obs;
  Rx<TextEditingController> get addDescriptionPitanie => _addDescriptionPitanie;

  RxList<String> nutritionList = <String>[].obs;
  List<int> repetition = [];
  List<int> equipment = [];
  final count = 0.obs;

  var jsonFilesPaths = <String>[]; // Список путей к файлам
  var isLoading = false.obs;

  @override
  void onInit() {
    addDefaultNutrition();
    super.onInit();
    loadJsonFiles();
    //addDefaultWorkout();
  }

  Future<void> loadJsonFiles() async {
    isLoading.value = true;
    try {
      final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assetsList = assetManifest.listAssets().where((String key) => key.startsWith('assets/default_workouts/') && key.endsWith('.json'))
          .toList();

      for (final assetPath in assetsList) {
          jsonFilesPaths.add(assetPath);
      }

      addDefaultWorkout();

    } catch (e) {
      print('Ошибка при загрузки JSON файлов: $e');
    } finally {
      isLoading.value = false;
    }
  }

  //если база пуста добавить тренировку поумолчанию
  Future<void> addDefaultWorkout() async {
    final workoutBox = Hive.box(dbWorkout);

    if (workoutBox.isEmpty){
      List jsonlist = jsonFilesPaths;

      for (var jsonStringPath in jsonlist) {

        var wrkDefault = readJson(jsonStringPath).then((wrk) {
          return Workouts(
              dateStart: wrk.dateStart,
              dateEnd: wrk.dateEnd,
              description: wrk.description,
              trains: [
                for(var wr in wrk.trains) Train(
                    nameWorkout: wr.nameWorkout,
                    repetitionWeight: wr.repetitionWeight,
                    weightEquipment: wr.weightEquipment,
                    setOfExercises: wr.setOfExercises),
              ]
          );
        });
        addWorkout(await wrkDefault,);
      }
    }


  }
  //'assets/default_workouts/default_workouts.json'
  Future<WorkoutProgram> readJson(String defaultJsonPath) async {
    final jsonString = await rootBundle.loadString(defaultJsonPath);
    final jsonMap = json.decode(jsonString);
    return WorkoutProgram.fromJson(jsonMap);
  }

  void addDefaultNutrition() {
    final nutritionBox = Hive.box(dbNutrition.value);

    String nutr =
        'Рисовая каша чашка, куринная грудка, два куска хлеба, стакан молока.';
    List<String> addNutrition = [];
    addNutrition.add(nutr);

    if (nutritionBox.isEmpty) {
      addFoodDiary(
        FoodDiary(
          dateStart: DateTime.now(),
          dateEnd: DateTime.now(),
          descriptionFood: 'Monthly meal plan',
          foodDiary: addNutrition,
        ),
      );
    }
  }

  void addWorkout(Workouts workouts) async {
    final workoutBox = Hive.box(dbWorkout);
    workoutBox.add(workouts);
    cleanFormWorkout();
  }

  void addFoodDiary(FoodDiary foodDiary) async {
    final nutritionBox = Hive.box(dbNutrition.value);
    nutritionBox.add(foodDiary);
    cleanFormNutrition();
  }

  // void changeFoodDairyInList(List list){
  //   final nutritionBox = Hive.box(dbNutrition.value);
  //   nutritionBox.add(list.add);
  // }

  void cleanFormWorkout() async {
    _addWorkoutApproaches.value.clear();
    _addWorkoutRepetitions.value.clear();
    _addDescriptionWorkout.value.clear();
  }

  void cleanFormNutrition() async {
    _addPitanie.value.clear();
    _addDescriptionPitanie.value.clear();
    //_dietList.clear();
  }

  getWorkoutByIndex(int index) {
    final workoutsBox = Hive.box(dbWorkout);
    return workoutsBox.getAt(index) as Workouts;
  }

  getNutritionByIndex(int index) {
    final nutritionBoxIndex = Hive.box(dbNutrition.value);
    return nutritionBoxIndex.getAt(index);
  }

  void deleteNutritionByIndex(int index) {
    final nutritionBox = Hive.box(dbNutrition.value);
    nutritionBox.deleteAt(index);
  }

  void deleteWorkoutByIndex(int index) {
    final trainBox = Hive.box(dbWorkout);
    trainBox.deleteAt(index);
  }

  Future getNutrition() async {
    Box box;
    try {
      box = Hive.box(dbNutrition.value);
    } catch (error) {
      box = (await Hive.openLazyBox(dbNutrition.value)) as Box;
    }
    var allNutritionBox = box.get(dbNutrition);
    if (allNutritionBox != null) _dietList.value = allNutritionBox;
  }
}

// updateContactByIndex(int index, Contact contact) {
//   final contactsBox = Hive.box(dbName.value);
//   contactsBox.putAt(index, contact);
// }
