
import 'package:FitnTrain/app/modules/user_name_module/user_name_controller.dart' show user_nameController;
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class user_nameBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => user_nameController());
  }
}
