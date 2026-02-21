import 'package:FitnTrain/app/modules/user_name_module/user_name_controller.dart' show user_nameController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class user_namePage extends GetView<user_nameController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('user_name Page')),
      body: Container(
        child: Obx(() => Container(
              child: Text(controller.obj),
            )),
      ),
    );
  }
}
