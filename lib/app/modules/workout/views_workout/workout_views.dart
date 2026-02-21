
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/style_widget.dart' show setOfExercisesColor, boxDecorationImageBackGrounds, colorSetOfExercises;
import '../../app_bar_sliver/sliver_app_bar.dart' show funcSliverAppBar;
import '../../training_plans/model/workouts.dart' show Workouts, Train;
import 'controllers/workout_controllers.dart';

class WorkoutViews extends StatelessWidget {
  WorkoutViews(
      {super.key, required this.trainingPlan, required this.inTheIndexSheet});
  final Workouts trainingPlan;
  final int inTheIndexSheet;

  final workoutController = Get.lazyPut(() => WorkoutControllers());

  @override
  Widget build(BuildContext context) {
    final List<Train> trainsList = trainingPlan.trains;
    int selectWorkout = 0;
    int lengthExercisesColor = setOfExercisesColor.length;
    int frameColor = 0;

    return Scaffold(
      body: DecoratedBox(
        decoration: boxDecorationImageBackGrounds(context),
        child: CustomScrollView(
          slivers: [
            funcSliverAppBar(textBar:
            'translates.workouts'.tr, //'Тренеровки',
                context: context),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clockAndDateNutrition(trainingPlan),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        trainingPlan.description,
                        overflow: TextOverflow.ellipsis, // Or TextOverflow.fade, TextOverflow.clip, TextOverflow.visible
                        maxLines: 6,
                        style: TextStyle(
                          //color: Color(0xffd57878),
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      for (var trains in trainsList)
                        Column(
                          children: [
                            //Text(DateFormat.yMMMEd().format(trains.dateTrain)),
                            //const SizedBox(height: 8,),
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(

                                color: colorSetOfExercises(trains.setOfExercises),

                                borderRadius: BorderRadius.circular(35.0),
                                border: Border.all(
                                    width: 2.0, color: const Color(0xffffffff)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Text(trains.nameWorkout,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15)
                                          ),
                                        ),
                                        onDoubleTap: () {},
                                        onLongPress: () {
                                          addRepsAndWeight(lengthExercisesColor,
                                              selectWorkout, trains, frameColor);
                                        },
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              for (var train
                                                  in trains.repetitionWeight)
                                                Text(train.toString(), style: TextStyle(fontSize: 20, color: Colors.black,),),
                                            ]),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            for (var equipment
                                                in trains.weightEquipment)
                                              Text(equipment.toString(), style: TextStyle(fontSize: 20, color: Colors.black,),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 30,)
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void addRepsAndWeight(int lenghExercisesColor, int selectWorkout,
      Train trains, int frameColor) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            GetBuilder<WorkoutControllers>(
              //assignId: true,
              builder: (logic) {
                return SizedBox(
                  width: Get.width,
                  height: Get.height / 6,
                  child: GridView.builder(
                    itemCount: lenghExercisesColor,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 55,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (BuildContext ctx, index) => GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: index == selectWorkout
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: index == selectWorkout
                                    ? Colors.white
                                    : Colors.transparent,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: setOfExercisesColor[index],
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onTap: () {
                        selectWorkout = index;
                        logic.frameColor = 1;
                        frameColor = index;
                        logic.funcFrame();
                      },
                    ),
                  ),
                );
              },
            ),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'translates.cancel'.tr, //"Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    trains.setOfExercises =
                        frameColor; //<---------------------------------------------------------------------

                    () async {
                      //workoutController.updateWorkoutByIndex(index, repetitionWeight);
                      var trainsSetofexercises = trains.setOfExercises;

                      Train trainList = Train(
                          nameWorkout: trains.nameWorkout.toString(),
                          repetitionWeight: trains.repetitionWeight,
                          weightEquipment: trains.weightEquipment,
                          setOfExercises: trainsSetofexercises);

                      //workoutController.updateWorkoutByIndex(
                      //  inTheIndexSheet, trainingPlan);

                      // var tr = [];
                      //
                      // for (var t in trainTodayObj.trainToday) {
                      //   tr.add(t);
                      // }
                      //
                      // List<Train> insertTrainToday = [];
                      // // insertTrainToday.addAll(tr as Iterable<Train>);
                      //
                      // for (var t in tr) {
                      //   insertTrainToday.add(t);
                      // }
                      //
                      // TrainingToday newTrainingToday = TrainingToday(
                      //   id: trainTodayObj.id,
                      //   trainingDay: trainTodayObj.trainingDay,
                      //   trainToday: insertTrainToday,
                      // );
                      //
                      // workoutController.updateRepetitionWeightByIndex(
                      //     indexTrainToday, newTrainingToday);
                      //controllerTrainToday.cleanRepetitionWeightController();

                      Get.back();
                    };

                    Get.back();
                  },
                  child: Text(
                    'translates.ok'.tr, //"OK",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
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