class NutritionPlan {
  final String goal;
  final int calories;
  final double protein;
  final double fats;
  final double carbs;
  final List<Meal> meals;

  NutritionPlan({
    required this.goal,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.meals,
  });
}

class Meal {
  final String name;
  final List<FoodItem> items;

  Meal({required this.name, required this.items});
}

class FoodItem {
  final String name;
  final double weightGrams;
  final double kcal;
  final double protein;
  final double fats;
  final double carbs;

  FoodItem({
    required this.name,
    required this.weightGrams,
    required this.kcal,
    required this.protein,
    required this.fats,
    required this.carbs,
  });
}
