import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../settings_profile/controller_settings_profile/controller_profile.dart';
import 'controller_picker/image_controller.dart';

// Виджет
class ProfileImagePicker extends StatelessWidget {
  final ImageController controller = Get.put(ImageController());
  var controllerProfile = Get.put(ProfileController());

  ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 100,),
          Obx(() {
            return controller.imagePath.isNotEmpty
                ?CircleAvatar( radius: 60, backgroundImage: FileImage(File(controller.imagePath.value)),
                  )
                : CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person, size: 40),);
          }),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child:Text('translates.cancel'.tr,
                    //'Cancel'
                ),
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: (){
                  controller.pickImage;
                  controllerProfile.pathToPhoto=controller.imagePath;
                },

                child: Text('translates.picker_image'.tr,
                    //'Picker image'
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
