import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/maki.dart';
import 'package:intl/intl.dart';

import '../../../constants/style_widget.dart' show boxDecorationImageBackGrounds, backGroundColor;
import '../../add_training_program/add_training_program.dart' show AddTrainingProgram;
import '../../app_bar_sliver/sliver_app_bar.dart' show funcSliverAppBar;
import '../../home/controllers/home_controller.dart' show HomeController;
import '../../training_day/training_today_view/training_today_view.dart' show TrainingTodayView;
import '../../workout/views_workout/workout_views.dart' show WorkoutViews;

class TrainingPlansView extends StatelessWidget {
  TrainingPlansView({super.key});

  final controllerTrain = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('translates.new'.tr,
            //"NEW  ",
            style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
          ),
          FloatingActionButton(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xffc4dfcc)
                  : Color(0xff202722),
              elevation: 12,
              child: Icon(Icons.add, color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xff202722)
                  : Color(0xffc4dfcc),
              ),
              onPressed: () {
                Get.to(() => const AddTrainingProgram());
              }),
        ],
      ),
      body: DecoratedBox(
        decoration: boxDecorationImageBackGrounds(context),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            funcSliverAppBar(textBar: 'translates.workouts'.tr, //'Тренеровки',
                context: context
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  ValueListenableBuilder(
                      valueListenable: Hive.box(controllerTrain.dbWorkout).listenable(),
                      builder: (context, Box trainBox, _) => ListView.builder(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: trainBox.length,
                          itemBuilder: (context, index) {
                        final train = controllerTrain.getWorkoutByIndex(index);
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => WorkoutViews(
                                trainingPlan: train, inTheIndexSheet: index));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Dismissible(
                              key: GlobalKey(),
                              confirmDismiss:
                                  (DismissDirection direction) async =>
                                      await showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                      'translates.delete_confirmation'.tr, //"Delete Confirmation"
                                  ),
                                  content: Text(
                                      'translates.sure_delete_this_item'.tr, //"Are you sure you want to delete this item?"
                                    ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: Text(
                                            'translates.delete'.tr, //"Delete"
                                        )),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: Text(
                                          'translates.cancel'.tr, //"Cancel"
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onDismissed: (DismissDirection direction) {
                                controllerTrain.deleteWorkoutByIndex(index);
                              },
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
                                      border: Border.all(width: 1.5, color: const Color(0x83bcc5c5)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        clockAndDateNutrition(train),
                                        Expanded(child: SizedBox()),
                                        Text(train.description,
                                          overflow: TextOverflow.fade,
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(() => TrainingTodayView());
                                                },
                                                icon: const Icon(
                                                  Icons.format_align_justify_rounded,
                                                  //color: Color(0xffd57878),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
                  SizedBox(height: 20,),
            ])),
          ],
        ),
      ),
    );
  }
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
              ? Color(0xffc4dfcc)
              : Color(0xff202722)

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