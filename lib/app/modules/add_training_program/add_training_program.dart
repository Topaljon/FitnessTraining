import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:intl/intl.dart';

import '../../constants/style_widget.dart' show boxDecorationImageBackGrounds, formFieldDecoration, iconDescription, colorSetOfExercises, textFieldDecorationLeft, textFieldDecorationRight;
import '../app_bar_sliver/sliver_app_bar.dart' show funcSliverAppBar;
import '../home/controllers/home_controller.dart';
import '../training_plans/model/workouts.dart' show Train, Workouts;

class AddTrainingProgram extends StatefulWidget {
  const AddTrainingProgram({
    super.key,
  });

  @override
  State<AddTrainingProgram> createState() => _AddTrainingProgramState();
}

class _AddTrainingProgramState extends State<AddTrainingProgram> {
  final _formKeyTrain = GlobalKey<FormState>();

  final controllerWorkout = Get.find<HomeController>();

  TextEditingController controllerFieldWorkout = TextEditingController();
  TextEditingController controllerNumberOfApproaches = TextEditingController();
  List<Train> trainList = [];

  int defaultApproaches = 0;
  int addedElement = 0;
  int defaultSuperset = 0;
  int approaches = 0;

  @override
  void dispose() {
    controllerFieldWorkout.dispose();
    controllerNumberOfApproaches.dispose();
    super.dispose();
  }

  void addTrainingProgram(rep, equip) {
    setState(() {
      trainList.add(Train(
        nameWorkout: controllerFieldWorkout.text,
        repetitionWeight: rep,
        weightEquipment: equip,
        setOfExercises: defaultSuperset,
      ),);}
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final DateTime dTimeStart = DateTime.now();

    int numberMonth = 1;
    int days = numberMonth*30;

    final DateTime dTimeEnd = dTimeStart.add(Duration(days: days));
    var descriptionWorkout = controllerWorkout.addDescriptionWorkout.value;
    Color colorStyle = Get.theme.brightness==Brightness.dark
        ? Color(0xffc4dfcc)
        : Color(0xff3e4a40);

    return Form(
      key: _formKeyTrain,
      child: Scaffold(
        body: DecoratedBox(
          decoration: boxDecorationImageBackGrounds(context),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              funcSliverAppBar(
                textBar: 'translates.workout'.tr,
                context: context,
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      clockAndDateNutrition(dTimeStart, context),
                      Row(
                        children: [
                          Iconify(Zondicons.dots_horizontal_triple, color: colorStyle,),
                          Text("1", style: TextStyle(color: colorStyle, fontSize: 16),),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Text('translates.many_months'.tr,
                              //"How many months will you study the program",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              decoration: formFieldDecoration(
                                  lText: 'translates.number_months'.tr,
                                  //'number of months',
                                  icon: Iconify(MaterialSymbols.calendar_month_outline, size: 20, color: Theme.of(context).brightness == Brightness.dark
                                      ? Color(0xffc4dfcc)
                                      : Color(0xff202722),),
                                  context: context),
                              onSaved: (value) {
                                numberMonth = int.parse(value!);
                              },

                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Iconify(Zondicons.dots_horizontal_triple, color: colorStyle,),
                          Text("2", style: TextStyle(color: colorStyle, fontSize: 16),),
                        ],
                      ),
                      TextFormField(
                            maxLines: 2,
                            controller: controllerWorkout.addDescriptionWorkout.value,
                            decoration: formFieldDecoration(
                                lText: 'translates.description'.tr,
                                //'Write a description',
                                icon: iconDescription(Icon(
                                  Icons.sticky_note_2_outlined,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Color(0xffc4dfcc)
                                      : Color(0xff3e4a40),
                                )),
                                context: context),
                          ),
                      Row(
                        children: [
                          Iconify(Zondicons.dots_horizontal_triple, color: colorStyle,),
                          Text("3", style: TextStyle(color: colorStyle, fontSize: 16),),
                        ],
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: trainList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) =>
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: colorSetOfExercises(trainList[index].setOfExercises),
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                    width: 1.5, color: const Color(0xffffffff)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Image.asset('assets/images/block_pull.png',
                                        width: 80,
                                        height: 80,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                              trainList[index].repetitionWeight.length.toString(),
                                              style: TextStyle(fontSize: 30, color: Colors.black,),

                                            ),
                                            Text('translates.sets'.tr,
                                                //"sets",
                                                style: TextStyle(fontSize: 14, color: Colors.black,)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 4, right: 4, bottom: 8),
                                      child: Text(trainList[index].nameWorkout,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        overflow: TextOverflow.ellipsis, // Or TextOverflow.fade, TextOverflow.clip, TextOverflow.visible
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              controller: controllerFieldWorkout,
                              decoration: textFieldDecorationLeft(
                                context: context,
                                labelTxt: 'translates.exercise'.tr,
                                //'Exercise',
                                icon: Transform.rotate(
                                  angle: 2.29,
                                  child: Iconify(Healthicons.exercise_outline, size: 25,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Color(0xffc4dfcc)
                                        : Color(0xff202722),
                                  ),
                                ),
                              ),

                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          SizedBox(
                            width: context.width / 4,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: controllerNumberOfApproaches,
                              decoration: textFieldDecorationRight(
                                  context: context,
                                  labelTxt: 'translates.number_approaches'.tr,
                                  //'number of approaches',
                                  icon: Iconify(MaterialSymbols.i_123_rounded,
                                    size: 25,
                                    color: Theme.of(context).brightness == Brightness.dark
                                      ? Color(0xffc4dfcc)
                                      : Color(0xff202722),),
                              ),
                            ),
                          ),
                        ],
                      ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text( 'translates.sports_exercise'.tr,
                           //"add a sports exercise",
                           style: TextStyle(fontSize: 16),),
                         IconButton(
                             onPressed:
                                 () {
                                   if (controllerNumberOfApproaches.text
                                       .isNotEmpty &&
                                       controllerFieldWorkout.text.isNotEmpty) {
                                     List<int> repetition = [];
                                     List<int> equipment = [];
                                     approaches = int.parse(
                                         controllerNumberOfApproaches.value
                                             .text);
                                     for (int i = 0; i < approaches; i++) {
                                       repetition.add(defaultApproaches);
                                       equipment.add(defaultApproaches);
                                     }
                                     addTrainingProgram(repetition, equipment);
                                     controllerNumberOfApproaches.clear();
                                     controllerFieldWorkout.clear();
                                   }else{
                                     Get.defaultDialog(
                                       title: "!!!",
                                       middleText: 'translates.unfilled_fields'.tr,
                                       //"There are unfilled fields",
                                       backgroundColor: Get.theme.brightness==Brightness.dark
                                           ? Color(0xffc4dfcc)
                                           : Color(0xff202722),
                                       titleStyle: TextStyle(color: Get.theme.brightness==Brightness.dark
                                           ? Color(0xff202722)
                                           : Color(0xffc4dfcc) ),
                                       middleTextStyle: TextStyle(color: Get.theme.brightness==Brightness.dark
                                           ? Color(0xff202722)
                                           : Color(0xffc4dfcc)
                                       ),
                                     );
                                   }
                                 },
                             icon: Icon(
                                 Icons.add_circle_outlined,
                                 size: 60,
                                 color: colorStyle
                             )
                         ),
                       ],
                     ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Get.theme.brightness==Brightness.dark
                              ? Color(0xff404040)
                              :Colors.white,
                          side: BorderSide(width: 2.0,
                          color: colorStyle
                        ),
                        ),
                        onPressed: () {
                          if (trainList.isNotEmpty) {
                            final newWorkouts = Workouts(
                              dateStart: dTimeStart,
                              dateEnd: dTimeEnd,
                              description: descriptionWorkout.text,
                              trains: trainList,
                            );
                            controllerWorkout.addWorkout(newWorkouts);
                            Get.back();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('translates.program'.tr,
                            //"Add program",
                            style: TextStyle(fontSize: 20,
                              color: colorStyle
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}

Row clockAndDateNutrition(DateTime timeStart, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
        child: Icon(
          Icons.access_time,
        ),
      ),
      Text(
        DateFormat.E().format(timeStart),
        style: TextStyle(fontSize: 16),
      ),
      Text(
        DateFormat.d().format(timeStart),
        style: TextStyle(fontSize: 30),
      ),
      RotatedBox(
        quarterTurns: -1,
        child: Text(
          DateFormat.MMM().format(timeStart),
          style: TextStyle(fontSize: 18),
        ),
      ),
    ],
  );
}