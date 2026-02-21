import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import '../../../../constants/style_widget.dart';
import '../../../app_bar_sliver/sliver_app_food.dart';
import '../../select_image/profile_image_picker.dart';
import 'controller_profile.dart';

class InputView extends GetView<ProfileController> {
  InputView({super.key});

  var controllerProfile = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {

    bool tMenOrWomen;
    String imagePath = controllerProfile.getImagePath.toString();

    return Scaffold(
        body: DecoratedBox(
          decoration: boxDecorationImageBackGrounds(context),
          child: CustomScrollView(
            slivers: [
              funcSliverAppBarFood(
                textBar: 'translates.input_profile'.tr,
                iconBar: Iconify(
                  Mdi.account,
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
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileImagePicker());
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 160,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(imagePath), //нужно будет заменить переменной
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Obx(() {
                        return SizedBox(
                            child: Text(
                              controllerProfile.name.value,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 28,
                              ),
                            ));
                      }),
                      SizedBox(
                        width: 14,
                      ),
                      Obx(() {
                        return SizedBox(
                            child: Text(
                              controllerProfile.lastName.value,
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 28,
                              ),
                            ));
                      }),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(() {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: controllerProfile.menOrWomen.value
                                      ? Colors.transparent
                                      : Color(0xFF8a817c),
                                  width: 3.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20,
                                ),
                              ),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  tMenOrWomen = false;
                                  controllerProfile.setMenOrWomen(tMenOrWomen);
                                },
                                child: Text('translates.male'.tr,
                                  //"male",
                                  style: Get.theme.brightness == Brightness.dark?
                                  TextStyle(color: controllerProfile.menOrWomen.value
                                      ? Color(0xff202722)
                                      : Color(0xfff2f4f1),
                                      fontSize: 18
                                  )
                                      : TextStyle(
                                      color: controllerProfile.menOrWomen.value
                                          ? Color(0x83818a87)
                                          : Color(0xff5c5860),
                                      fontSize: 18
                                  ),
                                )
                            ),
                          );
                        }),
                        SizedBox(width: 10,),
                        Obx(() {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: controllerProfile.menOrWomen.value
                                      ? Color(0xFF8a817c)
                                      : Colors.transparent,
                                  width: 3.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20,
                                ),
                              ),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  tMenOrWomen = true;
                                  controllerProfile.setMenOrWomen(tMenOrWomen);
                                },
                                child: Text('translates.female'.tr,
                                  //"female",
                                  style: TextStyle(color: controllerProfile
                                      .menOrWomen.value
                                      ? Color(0xFF8a817c)
                                      : Color(0xFFbcb8b1),
                                      fontSize: 18
                                  ),
                                )),
                          );
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: controllerProfile.nameController.value,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'translates.name'.tr,
                              //'Name',
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            controller: controllerProfile.lastNameController.value,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'translates.last_name'.tr,
                              //'Last name',
                            ),
                          ),
                          SizedBox(height: 5,),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: const Size(200, 30),
                                backgroundColor: Colors.black54,
                                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                var names = controllerProfile.nameController.value.text;
                                var lastNames =
                                    controllerProfile.lastNameController.value.text;
                                controllerProfile.setName(names);
                                controllerProfile.setLastName(lastNames);
                                controllerProfile.cleanForm();
                              },
                              child: Text('translates.input'.tr,
                                //'input',
                                style: const TextStyle(color: Colors.white),
                              )
                          ),
                        ],
                      ),
                    ),
                  ])),
            ],
          ),
        )
    );
  }
}