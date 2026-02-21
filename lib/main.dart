
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/drawer/user_name/model_bd/user.dart';
import 'app/modules/nutrition/model/food_diary.dart';
import 'app/modules/theme/app_theme.dart';
import 'app/modules/theme/theme_controller.dart';
import 'app/modules/training_day/controller/trainind_today_controller.dart';
import 'app/modules/training_day/model/training_today.dart' show TrainingTodayAdapter;
import 'app/modules/training_plans/model/workouts.dart';
import 'app/routes/app_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/translations/translate_app.g.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(WorkoutsAdapter());
  Hive.registerAdapter(FoodDiaryAdapter());
  Hive.registerAdapter(TrainAdapter());
  Hive.registerAdapter(TrainingTodayAdapter());

  await GetStorage.init();

  final controllerTrainToday = Get.put(TrainingTodayController());
  final controllerTheme = Get.put(ThemeController());

  List fitnessDb = [
    'userbox',
    'workout',
    'nutrition',
    controllerTrainToday.dbTrainingToday
  ];
  for (var db in fitnessDb) {
    await Hive.openBox(db);
  }

  runApp(
    GetMaterialApp(
      title: "Application",
      theme: AppThemes.lightTheme, // По умолчанию светлая тема
      darkTheme: AppThemes.darkTheme, // Указываем темную тему
      themeMode:
          controllerTheme.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      translations: Localization(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
    ),
  );
}
