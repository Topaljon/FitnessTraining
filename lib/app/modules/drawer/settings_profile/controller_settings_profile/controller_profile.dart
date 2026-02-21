import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final _storage = GetStorage('ProfileUser');

  RxString name = ''.obs;
  RxString lastName = ''.obs;
  RxString pathToPhoto = ''.obs;
  RxBool menOrWomen = false.obs;

  final Rx<TextEditingController> _nameController = TextEditingController().obs;

  Rx<TextEditingController> get nameController => _nameController;

  final Rx<TextEditingController> _lastNameController =
      TextEditingController().obs;

  Rx<TextEditingController> get lastNameController => _lastNameController;

  @override
  void onInit() {
    name.value = _storage.read('name') ?? '';
    lastName.value = _storage.read('lastName') ?? '';
    pathToPhoto.value = _storage.read('pathToPhoto') ?? '';
    menOrWomen.value = getMenOrWomen;
    super.onInit();
  }

  String get getName {
    return _storage.read('name') ?? '';
  }

  String get getLastName {
    return _storage.read('lastName') ?? '';
  }

  String get getImagePath {
    return _storage.read('pathToPhoto') ?? 'assets/images/fitness_user.png';
  }

  bool get getMenOrWomen {
    return _storage.read('menOrWomen') ?? true;
  }

  void setName(String newName) {
    name.value = newName;
    _storage.write('name', newName);
  }

  void setLastName(String newLastName) {
    lastName.value = newLastName;
    _storage.write('lastName', newLastName);
  }

  void setPathToPhoto(String newPathToPhoto) {
    pathToPhoto.value = newPathToPhoto;
    _storage.write('pathToPhoto', newPathToPhoto);
  }

  void setMenOrWomen(bool newMenOrWomen) {
    menOrWomen.value = newMenOrWomen;
    _storage.write('menOrWomen', newMenOrWomen);
  }

  void cleanForm() {
    _nameController.value.clear();
    _lastNameController.value.clear();
  }
}
