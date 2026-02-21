import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iconify_flutter_plus/icons/icon_park_solid.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconify_flutter_plus/icons/maki.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:intl/intl.dart';
import '../../../constants/style_widget.dart' show backGroundColor;
import '../../default_workouts/views/test_json_files_view.dart';
import '../../drawer/drawer_view.dart';
import '../../drawer/settings_profile/controller_settings_profile/controller_profile.dart';
import '../../meal_plan/view_meal_plan/meal_plan.dart' show MealPlan;
import '../../strength_indicators/view_strength_indicators/view_strength_indicators.dart' show ViewStrengthIndicators;
import '../../training_day/training_today_view/training_today_view.dart' show TrainingTodayView;
import '../../training_plans/view_training_plans/training_plans_view.dart' show TrainingPlansView;
import '../../workout/views_workout/workout_views.dart' show WorkoutViews;
import '../../your_food/view_ your_food/your_food_view.dart';
import '../controllers/home_controller.dart';
import '../../progress/progress.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerView(), //end drawer
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Theme
                  .of(context)
                  .brightness == Brightness.dark
                  ? AssetImage('assets/backgrounds/2.png')
                  : AssetImage('assets/backgrounds/1.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverAppBar(
                  expandedHeight: 210.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned(
                          top: -60.0,
                          left: -50.0,
                          child: SvgPicture.string(
                            _svg_b95bgj,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: -50.0,
                          left: -50.0,
                          child: SvgPicture.string(
                            _svg_kdlab2,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 16,
                          child: SizedBox(
                            child: Image(
                                  width: 150,
                                  height: 150,
                                  image: AssetImage(
                                      'assets/images/fitness_men.png')
                             ),
                          ),
                        ),
                        const Positioned(
                          left: 8,
                          top: 170.0,
                          child: Text(
                            'Fitness',
                            style: TextStyle(
                              fontFamily: 'Broken',
                              fontSize: 45.0,
                              letterSpacing: 3,
                              //color: Color(0xff2b2d30),
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 5.0),
                                  blurRadius: 2.0,
                                  color: Color(0xff736969),
                                ),
                              ],
                            ),
                            //style: styleText(fontSize: 45.0),
                            softWrap: false,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 16,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/images/fitness_user.png'),
                                //asset
                                fit: BoxFit.cover,
                              ),
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              border: Border.all(
                                  width: 1.0, color: const Color(0xffacacac)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  leading: Builder(
                    builder: (BuildContext context) =>
                        SizedBox(
                          height: 5,
                          width: 5,
                          child: Transform.rotate(
                            angle: 2.6,
                            child: GestureDetector(
                              child: const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Iconify(
                                      IconParkSolid.align_vertical_center_two,
                                      size: 15,
                                      color: Colors.white)),
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                        ),
                  ),
                ),

                //////////////////////////////// indicator
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        //width: context.width/2,
                        height: context.height / 3.8, //if mobile, portret
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const ProgressView(),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              children: [
                                //блок план питаний<-------------
                                blockTemplate(
                                  textBlock: 'translates.your_nutrition'.tr,
                                  //'Твоё питание',
                                  context: context,
                                  child: YourFoodView(),
                                  icon: "assets/icons/diner.svg",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),

                                blockTemplate(
                                    textBlock:'translates.todays_program'.tr,
                                    //'Программа \nна сегодня',
                                    context: context,
                                    child: TrainingTodayView(),
                                    icon: "assets/icons/gantel.svg"),
                              ],
                            ),
                          ],
                        ),
                      ),

                      //list2
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ValueListenableBuilder(
                              valueListenable:
                              Hive.box(homeController.dbWorkout)
                                  .listenable(),
                              builder: (context, Box trainBox, _) =>
                                  SizedBox(
                                    height: Get.height / 6,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: trainBox.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final train =
                                        homeController.getWorkoutByIndex(index);
                                        return GestureDetector(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(left: 10.0),
                                            child: ClipRect(
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 10.0, sigmaY: 10.0),
                                                child: Container(
                                                  alignment: Alignment
                                                      .bottomLeft,
                                                  width: Get.width / 3,
                                                  decoration: BoxDecoration(
                                                    color: Theme
                                                        .of(context)
                                                        .brightness ==
                                                        Brightness.dark
                                                        ? Color(0x83818a87)
                                                        : backGroundColor,
                                                    borderRadius:
                                                    BorderRadius.circular(25.0),
                                                    border: Border.all(
                                                        width: 2.0,
                                                        color: const Color(
                                                            0x83bcc5c5)),
                                                  ),
                                                  //boxDecorationPlansForToday,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: [
                                                      clockAndDate(
                                                          context, train),
                                                      //buildRowTest(context, train),
                                                      Expanded(
                                                          child: Container()),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 8, bottom: 8),
                                                        child:
                                                        Text(train.description, overflow: TextOverflow.ellipsis, // Or TextOverflow.fade, TextOverflow.clip, TextOverflow.visible
                                                          maxLines: 4,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Get.to(() =>
                                                WorkoutViews(
                                                  trainingPlan: train,
                                                  inTheIndexSheet: index,
                                                ));
                                          },
                                        );
                                      },
                                    ),
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ValueListenableBuilder(
                              valueListenable:
                              Hive.box(homeController.dbNutrition.value)
                                  .listenable(),
                              builder: (context, Box nutritionBox, _) =>
                                  SizedBox(
                                    height: Get.height / 6,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: nutritionBox.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final nutrition = homeController
                                              .getNutritionByIndex(index);
                                          return GestureDetector(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10.0),
                                              child: ClipRect(
                                                child: BackdropFilter(
                                                  filter: ImageFilter.blur(
                                                      sigmaX: 10.0,
                                                      sigmaY: 10.0),
                                                  child: Container(
                                                    alignment: Alignment
                                                        .bottomLeft,
                                                    width: Get.width / 3,
                                                    decoration: BoxDecoration(
                                                      color: Theme
                                                          .of(context)
                                                          .brightness ==
                                                          Brightness.dark
                                                          ? Color(0x83818a87)
                                                          : backGroundColor,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                      border: Border.all(
                                                          width: 2.0,
                                                          color: const Color(
                                                              0x83bcc5c5)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        clockAndDate(
                                                            context, nutrition),
                                                        Expanded(
                                                            child: Container()),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              bottom: 8),
                                                          child: Text(nutrition
                                                              .descriptionFood),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              Get.to(() =>
                                                  MealPlan(
                                                    datePlane: nutrition,
                                                  ));
                                            },
                                          );
                                        }),
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

            //bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              border: Border.all(
                                  width: 2.0, color: const Color(0xffc9c9c9)),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.to(() => ViewStrengthIndicators());
                              },
                              icon: Iconify(
                                Ic.round_bar_chart,
                                size: 40,
                                color: Theme
                                    .of(context)
                                    .brightness ==
                                    Brightness.dark
                                    ? backGroundColor
                                    : Color(0x833B3E3E),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(9999.0, 9999.0)),
                              border: Border.all(
                                  width: 2.0, color: const Color(0xffc9c9c9)),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.to(() => TrainingPlansView());
                              },
                              icon: Iconify(
                                Maki.fitness_centre_11,
                                size: 40,
                                color: Theme
                                    .of(context)
                                    .brightness ==
                                    Brightness.dark
                                    ? backGroundColor
                                    : Color(0x833B3E3E),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.elliptical(9999.0, 9999.0),
                              ),
                              border: Border.all(
                                width: 2.0,
                                color: const Color(0xffc9c9c9),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Get.to(() => YourFoodView());
                              },
                              icon: Iconify(
                                Mdi.food_variant,
                                size: 40,
                                color: Theme
                                    .of(context)
                                    .brightness ==
                                    Brightness.dark
                                    ? backGroundColor
                                    : Color(0x833B3E3E),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      // ClipOval(
                      //   child: BackdropFilter(
                      //     filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         borderRadius: const BorderRadius.all(
                      //           Radius.elliptical(9999.0, 9999.0),
                      //         ),
                      //         border: Border.all(
                      //           width: 2.0,
                      //           color: const Color(0xffc9c9c9),
                      //         ),
                      //       ),
                      //       child: IconButton(
                      //         onPressed: () {
                      //           //homeController.loadJsonListSheet();
                      //           Get.to(() => TestJsonWidget()
                      //           );
                      //         },
                      //         icon: Iconify(
                      //           Ic.outline_settings_suggest,
                      //           size: 40,
                      //           color: Theme
                      //               .of(context)
                      //               .brightness ==
                      //               Brightness.dark
                      //               ? backGroundColor
                      //               : Color(0x833B3E3E),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
          DateFormat.E().format(nutrition.dateStart),
          style: TextStyle(fontSize: 12),
        ),
        Text(
          DateFormat.d().format(nutrition.dateStart),
          style: TextStyle(fontSize: 24),
        ),
        RotatedBox(
          quarterTurns: -1,
          child: Text(
            DateFormat.MMM().format(nutrition.dateStart),
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  GestureDetector blockTemplate({textBlock, context, child, icon}) =>
      GestureDetector(
        onTap: () => Get.to(child),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: Get.width / 2.4,
              padding: const EdgeInsets.only(left: 8, top: 8),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Color(0x83818a87)
                    : backGroundColor,
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(width: 2.0, color: const Color(0x83bcc5c5)
                ),
              ),
              height: Get.height / 8 - 2,
              //width: Get.height/8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                    icon,
                    allowDrawingOutsideViewBox: true,
                    width: 25,
                    height: 25,
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? backGroundColor
                        : Color(0x83818a87),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    textBlock,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      //color: Color(0xff46525e),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

const String _svg_b95bgj =
    '<svg viewBox="-73.8 -49.9 287.8 319.4" ><path transform="matrix(0.819152, -0.573576, 0.573576, 0.819152, -282.5, 4.97)" d="M 229.8939208984375 146.9664154052734 C 245.832763671875 146.1604766845703 257.0516967773438 174.8032836914062 269.8519897460938 192.9385833740234 C 282.4859313964844 210.8381805419922 299.0513610839844 223.4227905273438 303.9812927246094 251.9325256347656 C 308.9165344238281 280.4730834960938 301.6222229003906 310.9476318359375 294.9688415527344 338.1893310546875 C 288.9947509765625 362.6498107910156 279.7813415527344 382.9368896484375 268.2006225585938 398.4335021972656 C 256.7852172851562 413.7089538574219 243.7316589355469 421.9929504394531 229.8939208984375 425.2686157226562 C 214.28173828125 428.9643249511719 197.3324279785156 434.2835693359375 183.9955139160156 418.3665161132812 C 170.3427276611328 402.0724182128906 164.7540893554688 370.5305480957031 159.6267547607422 341.4076538085938 C 154.4505310058594 312.007080078125 148.2607421875 279.7522583007812 154.5570068359375 251.1580352783203 C 160.7208557128906 223.1653137207031 178.5599060058594 214.7245483398438 191.44580078125 196.9032440185547 C 204.3133850097656 179.1072387695312 214.0060424804688 147.7698059082031 229.8939208984375 146.9664154052734" fill="#463f3a" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kdlab2 =
    '<svg viewBox="-58.0 0.0 291.1 259.5" ><path transform="matrix(0.87462, 0.48481, -0.48481, 0.87462, -1.05, -250.53)" d="M 261.5125122070312 208.7793273925781 C 282.4497680664062 209.4182434082031 301.8441772460938 214.57568359375 320.4537658691406 222.2364196777344 C 342.2889404296875 231.2249603271484 367.9853210449219 238.7975769042969 377.908935546875 256.6944580078125 C 388.1127624511719 275.0966796875 382.5684204101562 297.0694580078125 372.0992736816406 315.3771362304688 C 362.3305358886719 332.4599914550781 342.4838256835938 343.607177734375 322.5039978027344 353.58251953125 C 303.7983093261719 362.9216918945312 283.5761413574219 371.3297729492188 261.5125122070312 370.58984375 C 239.9588012695312 369.8670349121094 222.4853820800781 358.651611328125 204.1453857421875 349.6132202148438 C 184.1055297851562 339.7371215820312 160.4593505859375 332.4219970703125 149.9768524169922 315.6224670410156 C 138.7718811035156 297.6651000976562 136.9429321289062 275.6114807128906 146.3683319091797 257.0181884765625 C 155.5226135253906 238.959716796875 177.5382843017578 227.6078186035156 199.1923828125 218.5359802246094 C 218.3959350585938 210.4907836914062 239.82568359375 208.1175231933594 261.5125122070312 208.7793273925781" fill="#8a817a" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
