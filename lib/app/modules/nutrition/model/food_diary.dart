import 'package:hive_flutter/hive_flutter.dart';
part 'food_diary.g.dart';

@HiveType(typeId: 2)
class FoodDiary extends HiveObject {
  @HiveField(0)
  final DateTime dateStart;
  @HiveField(1)
  final DateTime dateEnd;
  @HiveField(2)
  final String descriptionFood;
  @HiveField(3)
  final List<String> foodDiary;

  FoodDiary(
      {required this.dateStart,
      required this.dateEnd,
      required this.descriptionFood,
      required this.foodDiary});

  Map<String, dynamic> toMap() {
    return {
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'descriptionFood': descriptionFood,
      'foodDiary': foodDiary,
    };
  }

  factory FoodDiary.fromMap(Map<String, dynamic> map) {
    return FoodDiary(
      dateStart: map['dateStart'] as DateTime,
      dateEnd: map['dateEnd'] as DateTime,
      descriptionFood: map['descriptionFood'] as String,
      foodDiary: map['foodDiary'] as List<String>,
    );
  }
}
