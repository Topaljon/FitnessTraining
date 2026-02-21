import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:intl/intl.dart';

import '../../../constants/style_widget.dart' show boxDecorationImageBackGrounds, backGroundColor;
import '../../app_bar_sliver/sliver_app_food.dart' show funcSliverAppBarFood;

class MealPlan extends StatelessWidget {
  MealPlan(
      {super.key,
      required this.datePlane,
      });

  dynamic datePlane;

  @override
  Widget build(BuildContext context) {
    //final List<Map<String, dynamic>> nutritionList = nutritionPlan.foodDiary;
    return Scaffold(
      //backgroundColor: const Color(0xffc9c9c9),
      body: DecoratedBox(
        decoration: boxDecorationImageBackGrounds(context),
        child: CustomScrollView(
          slivers: [
            funcSliverAppBarFood(
              textBar: 'translates.meal_plan'.tr,
              //'План питания',
              iconBar: Iconify(
                Mdi.food_variant,
                size: 40,
                color: Theme
                    .of(context)
                    .brightness ==
                    Brightness.dark
                    ? backGroundColor
                    : Color(0x833B3E3E),
              ),
              context: context,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: Get.width,
                          //height: Get.height/4.5,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          clockAndDateNutrition(datePlane),
                          // clockAndDateEndNutrition(datePlane),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              datePlane.descriptionFood.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                for (var ch in datePlane.foodDiary)
                                  Text(ch, style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                                    ),
                                  ),
                  ),
            ])),
          ],
        ),
      ),
    );
  }

  Row clockAndDateNutrition(nutrition) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
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
            ),
            Iconify(Mdi.dots_vertical),
            clockAndDateEndNutrition(nutrition),

          ],
        ),


      ],
    );
  }

  Row clockAndDateEndNutrition(nutrition) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormat.E().format(nutrition.dateEnd),
          style: TextStyle(fontSize: 16),
        ),
        Text(
          DateFormat.d().format(nutrition.dateEnd),
          style: TextStyle(fontSize: 30),
        ),
        RotatedBox(
          quarterTurns: -1,
          child: Text(
            DateFormat.MMM().format(nutrition.dateEnd),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}