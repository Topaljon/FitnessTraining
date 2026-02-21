import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:intl/intl.dart';

import '../../../constants/style_widget.dart' show boxDecorationImageBackGrounds, backGroundColor;
import '../../app_bar_sliver/sliver_app_food.dart' show funcSliverAppBarFood;
import '../../home/controllers/home_controller.dart' show HomeController;
import '../../meal_plan/view_meal_plan/meal_plan.dart' show MealPlan;
import '../../nutrition/add_view_nutrition/add_nutrition_view.dart' show AddNutritionView;

class YourFoodView extends GetView<HomeController> {
  YourFoodView({super.key});

  final controllerNutrition = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          //backgroundColor: const Color(0xffd57878),
          elevation: 12,
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() {
              //controllerNutrition.dietList.clear();
              return AddNutritionView();
            });
          }),
      body: DecoratedBox(
        decoration: boxDecorationImageBackGrounds(context),
        child: CustomScrollView(
          slivers: [
            funcSliverAppBarFood(
              context: context,
              textBar: 'translates.your_food'.tr, //'Твое питание',
              iconBar: Iconify(
                Mdi.food_variant,
                size: 40,
                color: Theme.of(context).brightness == Brightness.dark
                    ? backGroundColor
                    : Color(0x833B3E3E),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ValueListenableBuilder(
                valueListenable: Hive.box('nutrition').listenable(),
                builder: (context, Box nutritionBox, _) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: nutritionBox.length,
                    itemBuilder: (BuildContext context, int index) {
                      getNutritionByIndex(int indexes) {
                        return Hive.box('nutrition').getAt(indexes);
                      }

                      final nutrition = getNutritionByIndex(index);
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Dismissible(
                            confirmDismiss: (DismissDirection direction) async =>
                                await showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('translates.delete_confirmation'.tr, //"Delete Confirmation"
                                ),
                                content: Text('translates.sure_delete_this_item'.tr,
                                    //"Are you sure you want to delete this item?"
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: Text('translates.delete'.tr, //"Delete"
                                      )),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text('translates.cancel'.tr, //"Cancel"
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onDismissed: (DismissDirection direction) {
                              controllerNutrition.deleteNutritionByIndex(index);
                            },
                            background: dismissibleIcon(),
                            key: GlobalKey(),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  width: Get.width,
                                  height: Get.height/4.5,
                                  padding: const EdgeInsets.only(left: 8, top: 8),
                                  decoration: BoxDecoration(
                                    color: Theme
                                        .of(context)
                                        .brightness == Brightness.dark
                                        ? Color(0x83818a87)
                                        : backGroundColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(width: 2.0, color: const Color(0x83bcc5c5)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      clockAndDateNutrition(nutrition),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(nutrition.descriptionFood),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                                        child: Text(
                                          nutrition.foodDiary.first,
                                          overflow: TextOverflow.fade,
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.to(() => MealPlan(
                                datePlane: nutrition,
                                // descriptionPlane: nutrition.descriptionFood,
                                // listPlane: nutrition.foodDiary,
                              ));
                        },);
                    },);},
              )])),],),
      ),
    );
  }

  Row clockAndDateNutrition(nutrition) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            Icons.access_time,
            color: Get.theme.brightness==Brightness.dark
                ?Color(0xffd57878)
                :Color(0xFF463f3a),
          ),
        ),
        Text(
          DateFormat.E().format(nutrition.dateStart),
          style: TextStyle(fontSize: 16),
        ),
        Text(
          DateFormat.d().format(nutrition.dateStart),
          style: TextStyle(fontSize: 30),
        ),
        RotatedBox(
          quarterTurns: -1,
          child: Text(
            DateFormat.MMM().format(nutrition.dateStart),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  dismissibleIcon() => Container(
        color: Colors.deepOrangeAccent.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                width: Get.width / 2,
              )),
              Icon(Icons.delete_forever_sharp, color: Colors.white),
            ],
          ),
        ),
      );
}
