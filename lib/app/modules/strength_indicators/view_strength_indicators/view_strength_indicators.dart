import 'dart:ui' show ImageFilter;
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:intl/intl.dart';
import '../../../constants/style_widget.dart';
import '../../app_bar_sliver/sliver_app_food.dart' show funcSliverAppBarFood;
import '../../training_day/controller/trainind_today_controller.dart';

class ViewStrengthIndicators extends StatelessWidget {
  ViewStrengthIndicators({super.key});

  final controllerTrainToday = Get.find<TrainingTodayController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xffc9c9c9),
      body: DecoratedBox(
        decoration: boxDecorationImageBackGrounds(context),
        child: CustomScrollView(
          slivers: [
            funcSliverAppBarFood(
              textBar:'translates.prodress'.tr,
        //'Progress',
              iconBar: Iconify(
                Ic.round_bar_chart,
                size: 40,
                color: Theme.of(context).brightness == Brightness.dark
                    ? backGroundColor
                    : Color(0x833B3E3E),
              ),
              context: context,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ValueListenableBuilder(
                  valueListenable:
                      Hive.box(controllerTrainToday.dbTrainingToday).listenable(),
                  builder: (context, Box trainingTodayBox, _) {
                    return SizedBox(
                      height: Get.height - Get.height / 6,
                      //<---- можно поиграть с размером экрана по высоте,
                      // если есть верхний лист то эта высота, если нет - без него

                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: trainingTodayBox.length,
                          itemBuilder: (context, indexTrainingToday) {
                            final trainToday = controllerTrainToday
                                .getTrainingTodayByIndex(indexTrainingToday);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: DateTime.fromMicrosecondsSinceEpoch(
                                          trainToday.trainingDay)
                                      .isBefore(DateTime.now()
                                          .subtract(const Duration(days: 180)))
                                  ? Container()
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        clockAndDate(context, trainToday),
                                        //<--------------------------------------------------------------
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(26),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(26.0),
                                                border: Border.all(
                                                  width: 2.0,
                                                  color: Theme
                                                      .of(context)
                                                      .brightness == Brightness.dark
                                                      ? backGroundColor
                                                      : Color(0x83818a87),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  for (int indexTrainsToday = 0;
                                                      indexTrainsToday <
                                                          trainToday
                                                              .trainToday.length;
                                                      indexTrainsToday++)
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          width: Get.width,
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: Get.width/2,
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
                                                                            indexTrainsToday].nameWorkout,
                                                                      style: TextStyle(
                                                                          color: Theme
                                                                          .of(context)
                                                                          .brightness == Brightness.dark
                                                                          ? Color(
                                                                              0xfff2f4f1)
                                                                          : Color(
                                                                              0x93000000),
                                                                          fontSize: 16),
                                                                  ),
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: <Widget>[
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: <Widget>[
                                                                        for (var train in trainToday
                                                                            .trainToday[
                                                                                indexTrainsToday]
                                                                            .repetitionWeight)
                                                                          Text(train
                                                                              .toString(),
                                                                            style: TextStyle(fontSize: 20),),
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: <Widget>[
                                                                      for (var equipment in trainToday
                                                                          .trainToday[
                                                                              indexTrainsToday]
                                                                          .weightEquipment)
                                                                        Text(equipment
                                                                            .toString(),
                                                                          style: TextStyle(fontSize: 20),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],),],
                                              ),),),),
                                      ],),);}
                      ),);},
                ),],),
            ),],),
      ),);}

  SizedBox buildChartBox(BuildContext context, trainToday, int i) {
    return SizedBox(
      width: context.width / 2.2,
      height: context.height / 4.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 2,
              color: Colors.black,
            )),
        child: Chart(
          state: ChartState<void>(
            data: ChartData([
              (trainToday.trainToday[i].weightEquipment as List)
                  .map((e) => ChartItem<void>(e.toDouble()))
                  .toList()
            ]),
            itemOptions: BarItemOptions(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              barItemBuilder: (_) => BarItem(
                radius: const BorderRadius.vertical(
                  top: Radius.circular(16.0),
                  bottom: Radius.circular(16.0),
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Row clockAndDate(BuildContext context, nutrition) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.access_time,
          color: Theme
              .of(context)
              .brightness == Brightness.dark
              ? backGroundColor
              : Color(0x83818a87),
        ),
      ),
      Text(
        DateFormat.E().format(DateTime
            .fromMicrosecondsSinceEpoch(
            nutrition.trainingDay)),
        style: TextStyle(fontSize: 12),
      ),
      Text(
        DateFormat.d().format(DateTime
            .fromMicrosecondsSinceEpoch(
            nutrition.trainingDay)),
        style: TextStyle(fontSize: 24),
      ),
      RotatedBox(
        quarterTurns: -1,
        child: Text(
          DateFormat.MMM().format(DateTime
              .fromMicrosecondsSinceEpoch(
              nutrition.trainingDay)),
          style: TextStyle(fontSize: 14),
        ),
      ),
    ],
  );
}