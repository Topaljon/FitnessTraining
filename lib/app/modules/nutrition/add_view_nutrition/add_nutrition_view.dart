import 'dart:ui' show ImageFilter;
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/cil.dart';
import 'package:iconify_flutter/icons/material_symbols.dart' show MaterialSymbols;
import 'package:iconify_flutter/icons/zondicons.dart' show Zondicons;
import 'package:iconify_flutter_plus/icons/mdi.dart' show Mdi;
import '../../../constants/style_widget.dart' show boxDecorationImageBackGrounds, backGroundColor, formFieldDecoration, iconDescription;
import '../../add_training_program/add_training_program.dart';
import '../../app_bar_sliver/sliver_app_food.dart' show funcSliverAppBarFood;
import '../../home/controllers/home_controller.dart' show HomeController;
import '../model/food_diary.dart' show FoodDiary;
import '../randomIcon/random_icon.dart' show getRandomIcon;

class AddNutritionView extends StatefulWidget {

  const AddNutritionView({super.key});

  @override
  State<AddNutritionView> createState() => _AddNutritionViewState();
}

class _AddNutritionViewState extends State<AddNutritionView> {
  final _formKey = GlobalKey<FormState>();
  final DateTime dTimeStart = DateTime.now();
  final controllerNutrition = Get.find<HomeController>();

  TextEditingController controllerTextField = TextEditingController();
  List<String> nutritionList = [];

  @override
  void dispose() {
    controllerTextField.dispose();
    super.dispose();
  }

  void addesNutr() {
    setState(() {
      nutritionList.add(controllerTextField.text);
    });
  }

  @override
  Widget build(BuildContext context) {

    int numberMonth = 1;
    int days = numberMonth*30;

    final DateTime dTimeEnd = dTimeStart.add(Duration(days: days));
    var descriptionNutrition = controllerNutrition.addDescriptionPitanie.value;

    Color colorStyle = Get.theme.brightness==Brightness.dark
        ? Color(0xffc4dfcc)
        : Color(0xff3e4a40);

    return Form(
      key: _formKey,
      child: Scaffold(
        body: DecoratedBox(decoration: boxDecorationImageBackGrounds(context),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              funcSliverAppBarFood(
                textBar: 'translates.nutrition'.tr,
                //'Питание',
                iconBar: Iconify(
                  Mdi.food_variant,
                  size: 30,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      clockAndDateNutrition(dTimeStart, context),
                      Row(
                        children: [
                          Iconify(Zondicons.dots_horizontal_triple, color: colorStyle,),
                          Text("1", style: TextStyle(color: colorStyle, fontSize: 24),),
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
                          Text("2", style: TextStyle(color: colorStyle, fontSize: 24),),
                        ],
                      ),
                      TextFormField(
                        maxLines: 2,
                        controller:
                      controllerNutrition.addDescriptionPitanie.value,
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
                          Text("3", style: TextStyle(color: colorStyle, fontSize: 24),),
                        ],
                      ),

                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 0.9,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: nutritionList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Theme
                                          .of(context)
                                          .brightness == Brightness.dark
                                          ? Color(0xff758576)
                                          : Color(0xffc4dfcc),
                                      borderRadius: BorderRadius.circular(25.0),

                                      border: Border.all(
                                          width: 2, color: const Color(
                                          0x83bcc5c5)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // Image.asset('assets/images/block_pull.png',
                                        //   width: 80,
                                        //   height: 80,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Iconify(
                                            getRandomIcon(),
                                            size: 30,
                                            color: Theme.of(context).brightness == Brightness.dark
                                              ? Color(0xffc4dfcc)
                                              : Color(0xff3e4a40),),
                                        ),
                                        Expanded(
                                            child: Container()),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                          child: Text(
                                            nutritionList[index],
                                            style: const TextStyle(fontSize: 15),
                                            overflow: TextOverflow.ellipsis, // Or TextOverflow.fade, TextOverflow.clip, TextOverflow.visible
                                            maxLines: 2,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            maxLines: 2,
                            controller: controllerTextField,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Iconify(Cil.dinner,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Color(0xffc4dfcc)
                                      : Color(0xff202722),
                                ),
                              ),

                              labelText: 'translates.dish'.tr,
                              fillColor: Theme
                                  .of(context)
                                  .brightness == Brightness.dark
                                  ? Color(0xff3a3939).withValues(alpha: 0.9)
                                  :Colors.white.withValues(alpha: 0.5),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Color(0xffc4dfcc)
                                        : Color(0xff3e4a40)
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.5,
                                    color: Color(0xffa2a3a2)
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: Icon(
                                  Icons.add_circle_outlined,
                                  size: 60,
                                  color: colorStyle),
                              onPressed: () {
                                addesNutr();
                                controllerTextField.clear();
                              },
                            )),
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
                          if (nutritionList.isNotEmpty) {
                            final newFoodDiary = FoodDiary(
                              dateStart: dTimeStart,
                              dateEnd: dTimeEnd,
                              descriptionFood: descriptionNutrition.text,
                              foodDiary: nutritionList,
                            );
                            controllerNutrition.addFoodDiary(newFoodDiary);
                            Get.back();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
                          child: Text('translates.add'.tr,
                            style: TextStyle(fontSize: 20,
                                color: colorStyle
                            ),
                              //"Add"
                          ),
                        ),
                      )
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

const String _svg_uf85dy =
    '<svg viewBox="0.4 0.0 28.2 34.4" ><path transform="translate(0.0, 0.0)" d="M 17.87090492248535 10.11493396759033 L 17.87090492248535 10.15794563293457 C 16.7263011932373 6.623812198638916 15.13619136810303 3.21154522895813 13.32675743103027 0 C 16.10944747924805 1.964204072952271 17.63101959228516 6.724173069000244 17.87090492248535 10.11493396759033 Z M 19.97505760192871 18.29433822631836 C 20.4616870880127 19.51300430297852 20.68101119995117 20.81052780151367 20.68101119995117 22.12238693237305 C 20.68101119995117 27.34831619262695 16.96618843078613 31.59931373596191 11.82574939727783 31.49178314208984 L 12.07249069213867 31.47027778625488 C 16.83596420288086 28.33758544921875 19.09090232849121 23.4987621307373 19.09090232849121 17.68500518798828 C 19.09090232849121 15.12580490112305 18.67966842651367 12.58810997009277 17.87775993347168 10.15794563293457 C 17.94629859924316 10.94649505615234 17.94629859924316 11.75654983520508 17.94629859924316 12.53793048858643 C 17.94629859924316 18.71011924743652 16.78113174438477 28.77487182617188 10.45496559143066 31.3555793762207 C 6.232953548431396 30.58853340148926 3.299476861953735 26.74615287780762 3.299476861953735 22.12238693237305 C 3.299476861953735 17.03982925415039 6.986884593963623 12.5594367980957 12.00395107269287 12.5594367980957 C 13.08001613616943 12.5594367980957 14.16293525695801 12.76732635498047 15.15675354003906 13.20461273193359 C 15.26641654968262 12.1938362121582 15.57484340667725 11.19739723205566 16.01349449157715 10.29414939880371 C 14.7386646270752 9.813851356506348 13.36788082122803 9.577286720275879 12.00395107269287 9.577286720275879 C 1.620267152786255 9.577286720275879 -3.335115194320679 22.73888778686523 3.655880689620972 30.66022300720215 C 8.014971733093262 35.67109298706055 15.9929313659668 35.62808227539062 20.34516906738281 30.66022300720215 C 23.98460006713867 26.53826141357422 24.25875663757324 21.09010314941406 22.689208984375 17.14735794067383 C 21.86673927307129 17.68500518798828 20.94831466674805 18.08644866943359 19.97505760192871 18.29433822631836 Z M 26.99346923828125 0.7885490655899048 C 24.99897956848145 5.254604339599609 21.77078437805176 3.957082748413086 19.55011558532715 6.172188282012939 C 18.75506210327148 6.975074768066406 18.22730827331543 8.451812744140625 18.22730827331543 9.562950134277344 C 18.22730827331543 10.50920867919922 18.51517295837402 11.38378143310547 18.99494934082031 12.17232990264893 C 22.04494094848633 11.43396186828613 25.31426048278809 9.08265209197998 26.5959415435791 6.078996181488037 C 26.54796409606934 6.444596290588379 26.28751564025879 7.039592266082764 26.12987518310547 7.362181186676025 C 24.82763290405273 9.763670921325684 21.97640228271484 11.77088737487793 19.72146415710449 13.06840801239014 C 20.67415809631348 14.03617382049561 21.88730049133301 14.8032169342041 23.25808525085449 14.8032169342041 C 28.33683776855469 14.8032169342041 30.33132743835449 5.756408214569092 26.99346923828125 0.7885490655899048 Z" fill="#d57878" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
