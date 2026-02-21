import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/maki.dart';
import 'package:intl/intl.dart';
import '../../../constants/style_widget.dart';
import '../../app_bar_sliver/sliver_app_bar.dart';
import '../../home/controllers/home_controller.dart';
import '../../training_plans/model/workouts.dart';
import '../controller/trainind_today_controller.dart';
import '../model/training_today.dart';

class TrainingTodayView extends StatelessWidget {
  TrainingTodayView({super.key});
  final controllerTrainToday = Get.find<TrainingTodayController>();
  final controllerTrain = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DecoratedBox(
          decoration: boxDecorationImageBackGrounds(context),
          child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
            funcSliverAppBar(
              textBar: 'translates.program_for_today'.tr,
              //'Программа на сегодня',
              context: context,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box(controllerTrain.dbWorkout).listenable(),
                    builder: (context, Box trainBox, _) => SizedBox(
                          height: Get.height / 5,
                          child: ListView.builder(
                              padding: const EdgeInsets.only(left: 6, right: 6),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: trainBox.length,
                              itemBuilder: (context, index) {
                                final train =
                                    controllerTrain.getWorkoutByIndex(index);
                                return GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: "",
                                      content: Column(
                                        children: [
                                          Icon(
                                            Icons.bookmark_add,
                                            size: 32,
                                            color: Colors.deepOrangeAccent,
                                          ),
                                          SizedBox(
                                            height: 24,
                                          ),
                                          Text('translates.add_a_training_program'.tr,
                                              //"Add a training program?"
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                      radius: 24,
                                      textConfirm: 'translates.yes'.tr,
                                      //"Yes",
                                      textCancel: 'translates.no'.tr,
                                      //"No",
                                      onConfirm: () {
                                        final trainTodayObg = TrainingToday(
                                            id: DateTime.now()
                                                .microsecondsSinceEpoch
                                                .toString(),
                                            trainingDay: DateTime.now()
                                                .microsecondsSinceEpoch,
                                            trainToday: train.trains);
                                        controllerTrainToday
                                            .addTrainingToday(trainTodayObg);
                                        Get.back();
                                      },
                                      onCancel: () {},
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, right: 6, bottom: 4.0),
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          width: Get.width / 1.8,
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              clockAndDateNutrition(train),
                                              Expanded(child: SizedBox()),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                                                  child: Text(
                                                    train.description,
                                                    overflow: TextOverflow.visible,
                                                    maxLines: 6,
                                                    style: TextStyle(fontSize: 14,),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    ),
                ),
                //<-------------------------------------------------создать условие по времени

                //DateTime.now().isBefore(other)?   :  Container(),
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box(controllerTrainToday.dbTrainingToday).listenable(),
                  builder: (context, Box trainingTodayBox, _) {
                    return SizedBox(
                      height: Get.height-340, //<---- можно поиграть с размером экрана по высоте,
                      // если есть верхний лист то эта высота, если нет - без него

                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: trainingTodayBox.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (context, indexTrainingToday) {
                            final trainToday = controllerTrainToday
                                .getTrainingTodayByIndex(indexTrainingToday);
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: DateTime.fromMicrosecondsSinceEpoch(
                                            trainToday.trainingDay)
                                        .isBefore(DateTime.now()
                                            .subtract(const Duration(days: 4)))
                                    ? Container()
                                    : Dismissible(
                                        key: GlobalKey(),
                                        background: ColoredBox(
                                          color: Colors.redAccent
                                              .withValues(alpha: 0.4),
                                          child: const Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 24),
                                              child: Icon(
                                                Icons.delete_outlined,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                        confirmDismiss:
                                            (DismissDirection direction) async =>
                                                await showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title:
                                                Text('translates.delete_confirmation'.tr,
                                                    //"Delete Confirmation"
                                                ),
                                            content: Text('translates.sure_delete_this_item'.tr,
                                               //"Are you sure you want to delete this item?"
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text('translates.delete'.tr,
                                                      //"Delete"
                                                  )),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: Text('translates.cancel'.tr,
                                                    //"Cancel"
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onDismissed:
                                            (DismissDirection direction) {
                                          controllerTrainToday
                                              .deleteTrainTodayByIndex(
                                                  indexTrainingToday);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(DateFormat.yMMMd()
                                                .format(DateTime
                                                    .fromMicrosecondsSinceEpoch(
                                                        trainToday
                                                            .trainingDay))
                                                .toString()),
                                            //<--------------------------------------------------------------
                                            for (int indexTrainsToday = 0;
                                                indexTrainsToday <
                                                    trainToday.trainToday.length;
                                                indexTrainsToday++)
                                              Column(
                                                children: [
                                                  Container(
                                                    width: Get.width,

                                                    decoration: BoxDecoration(

                                                      color: colorSetOfExercises(trainToday.trainToday[
                                                        indexTrainsToday].setOfExercises),

                                                      borderRadius: BorderRadius.circular(25.0),
                                                      border: Border.all(
                                                          width: 1.5, color: const Color(0xffffffff)),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 16,
                                                                      top: 8,
                                                                      bottom: 8),
                                                              child: Text(
                                                                  trainToday
                                                                      .trainToday[
                                                                          indexTrainsToday]
                                                                      .nameWorkout,
                                                                  style: const TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 15)
                                                              ),
                                                            )),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              GestureDetector(
                                                                onTap: () {
                                                                  dial(
                                                                    indexTrainToday:
                                                                        indexTrainingToday,
                                                                    trainsToday:
                                                                        trainToday
                                                                                .trainToday[
                                                                            indexTrainsToday],
                                                                    trainTodayObj:
                                                                        trainToday,
                                                                    indexLine:
                                                                        indexTrainsToday,
                                                                  );
                                                                },
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: <Widget>[
                                                                      for (var train in trainToday
                                                                          .trainToday[
                                                                              indexTrainsToday]
                                                                          .repetitionWeight)
                                                                        Text(train
                                                                            .toString(), style: TextStyle(fontSize: 20,
                                                                          color: Colors.black,
                                                                        )),
                                                                    ]),
                                                              ),
                                                              const SizedBox(
                                                                height: 8,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  dialWeightEquipment(
                                                                    indexTrainToday:
                                                                        indexTrainingToday,
                                                                    trainsToday:
                                                                        trainToday
                                                                                .trainToday[
                                                                            indexTrainsToday],
                                                                    trainTodayObj:
                                                                        trainToday,
                                                                    indexLine:
                                                                        indexTrainsToday,
                                                                  );
                                                                },
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: <Widget>[
                                                                    for (var equipment in trainToday
                                                                        .trainToday[
                                                                            indexTrainsToday]
                                                                        .weightEquipment)
                                                                      Text(equipment
                                                                          .toString(), style: TextStyle(fontSize: 20, color: Colors.black,))
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ));
                          }),
                    );
                  },
                ),
              ]),
            ),
          ]),
        ),
      );

  Text buildText(train) {
    return Text(
                                                  "${DateFormat.yMMMEd().format(train.dateStart)} - ${DateFormat.yMMMEd().format(train.dateEnd)}",
                                                  style: const TextStyle(
                                                      color: Color(0xffd57878),
                                                      fontSize: 16),
                                                );
  }

  void dial({trainsToday, indexTrainToday, trainTodayObj, indexLine}) async {
    controllerTrainToday.updateRepetitionWeightController;
    List<int> trainingTodayList = [];

    for (int train = 0; train < trainsToday.repetitionWeight.length; train++) {
      controllerTrainToday.updateRepetitionWeightController.add(
          TextEditingController(
              text: trainsToday.repetitionWeight[train].toString()));
    }

    Get.defaultDialog(
      title: 'translates.number_of_repetitions'.tr,
      //"Number of repetitions",
      middleText: "",
      backgroundColor: const Color(0xffc9c9c9),
      titleStyle: const TextStyle(color: Colors.black),
      middleTextStyle: const TextStyle(color: Colors.black),
      barrierDismissible: false,
      onConfirm: () async {
        for (var intController
            in controllerTrainToday.updateRepetitionWeightController) {
          trainingTodayList.add(int.parse(intController!.text));
        }

        Train trainList = Train(
            nameWorkout: trainsToday.nameWorkout.toString(),
            repetitionWeight: trainingTodayList,
            weightEquipment: trainsToday.weightEquipment,
            setOfExercises: trainsToday.setOfExercises);

        var tr = [];

        for (var t in trainTodayObj.trainToday) {
          tr.add(t);
        }

        tr.removeAt(indexLine);
        //print(indexLine);
        tr.insert(indexLine, trainList);
        //print(indexLine);

        List<Train> insertTrainToday = [];
        // insertTrainToday.addAll(tr as Iterable<Train>);

        for (var t in tr) {
          insertTrainToday.add(t);
        }

        TrainingToday newTrainingToday = TrainingToday(
          id: trainTodayObj.id,
          trainingDay: trainTodayObj.trainingDay,
          trainToday: insertTrainToday,
        );

        controllerTrainToday.updateRepetitionWeightByIndex(
            indexTrainToday, newTrainingToday);

        controllerTrainToday.cleanRepetitionWeightController();

        Get.back();
      },
      onCancel: () async {
        controllerTrainToday.cleanRepetitionWeightController();
      },
      content: Row(
        children: [
          for (int train = 0;
              train < trainsToday.repetitionWeight.length;
              train++)
            SizedBox(
                width: (Get.width - 140) / trainsToday.repetitionWeight.length,
                child: Column(
                  children: [
                    //Text(trainsToday.repetitionWeight[train].toString()),
                    TextFormField(
                      controller: controllerTrainToday
                          .updateRepetitionWeightController[train],
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )),
        ],
      ),
      textConfirm: 'translates.confirm'.tr, //"Confirm",
      textCancel: 'translates.cancel'.tr, //"Cancel",
    );
  }

  void dialWeightEquipment(
      {required int indexTrainToday,
      required trainsToday,
      required trainTodayObj,
      required int indexLine}) async {
    //controllerTrainToday.updateWeightEquipmentController;
    List<double> trainingTodayList = [];

    for (int train = 0; train < trainsToday.weightEquipment.length; train++) {
      controllerTrainToday.updateWeightEquipmentController.add(
          TextEditingController(
              text: trainsToday.weightEquipment[train].toString()));
    }

    Get.defaultDialog(
      title: 'translates.weight'.tr, //"Weight",
      middleText: "",
      backgroundColor: const Color(0xffc9c9c9),
      titleStyle: const TextStyle(color: Colors.black),
      middleTextStyle: const TextStyle(color: Colors.black),
      barrierDismissible: false,
      onConfirm: () async {
        for (var intController
            in controllerTrainToday.updateWeightEquipmentController) {
          trainingTodayList.add(double.parse(intController!.text));
        }

        Train trainList = Train(
            nameWorkout: trainsToday.nameWorkout.toString(),
            repetitionWeight: trainsToday.repetitionWeight,
            weightEquipment: trainingTodayList,
            setOfExercises: trainsToday.setOfExercises);

        var we = [];

        for (var w in trainTodayObj.trainToday) {
          we.add(w);
        }

        we.removeAt(indexLine);
        //print(indexLine);
        we.insert(indexLine, trainList);
        //print(indexLine);
        List<Train> insertTrainToday = [];
        // insertTrainToday.addAll(tr as Iterable<Train>);

        for (var w in we) {
          insertTrainToday.add(w);
        }

        TrainingToday newTrainingToday = TrainingToday(
          id: trainTodayObj.id,
          trainingDay: trainTodayObj.trainingDay,
          trainToday: insertTrainToday,
        );

        controllerTrainToday.updateWeightEquipmentByIndex(
            indexTrainToday, newTrainingToday);

        controllerTrainToday.cleanWeightEquipmentController();

        Get.back();
      },
      onCancel: () async {
        controllerTrainToday.cleanWeightEquipmentController();
      },
      content: Row(
        children: [
          for (int train = 0;
              train < trainsToday.weightEquipment.length;
              train++)
            SizedBox(
                width: (Get.width - 140) / trainsToday.weightEquipment.length,
                child: Column(
                  children: [
                    //Text(trainsToday.repetitionWeight[train].toString()),
                    TextFormField(
                      controller: controllerTrainToday
                          .updateWeightEquipmentController[train],
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )),
        ],
      ),
      textConfirm: 'translates.confirm'.tr, //"Confirm",
      textCancel: 'translates.cancel'.tr, //"Cancel",
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

}

const String _svg_ocuf0t =
    '<svg viewBox="0.0 3.0 60.0 42.0" ><path  d="M 9.75 9 L 5.25 9 C 4.010000228881836 9 3 10.01000022888184 3 11.25 L 3 21 C 1.340000033378601 21 0 22.34000015258789 0 24 C 0 25.65999984741211 1.340000033378601 27 2.920000076293945 27 L 3 36.75 C 3 38 4.010000228881836 39 5.25 39 L 9.75 39 C 11 39 12 38 12 36.75 L 12 11.25 C 12 10.01000022888184 11 9 9.75 9 Z M 42.75 3 L 38.25 3 C 37.0099983215332 3 36 4.010000228881836 36 5.25 L 36 21 L 24 21 L 24 5.25 C 24 4.010000228881836 23 3 21.75 3 L 17.25 3 C 16.01000022888184 3 15 4.010000228881836 15 5.25 L 15 42.75 C 15 44 16.01000022888184 45 17.25 45 L 21.75 45 C 23 45 24 44 24 42.75 L 24 27 L 36 27 L 36 42.75 C 36 43.9900016784668 37.0099983215332 45 38.25 45 L 42.75 45 C 43.9900016784668 45 45 43.9900016784668 45 42.75 L 45 5.25 C 45 4.010000228881836 44 3 42.75 3 Z M 57 21 L 57 11.25 C 57 10.01000022888184 56 9 54.75 9 L 50.25 9 C 49.0099983215332 9 48 10.01000022888184 48 11.25 L 48 36.75 C 48 37.9900016784668 49.0099983215332 39 50.25 39 L 54.75 39 C 55.9900016784668 39 57 37.9900016784668 57 36.75 L 57 27 C 58.65999984741211 27 60 25.65999984741211 60 24 C 60 22.34000015258789 58.65999984741211 21 57 21 Z" fill="#d57878" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
