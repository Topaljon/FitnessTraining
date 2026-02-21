import 'package:FitnTrain/app/modules/home/controllers/home_controller.dart' show HomeController;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestJsonWidget extends StatelessWidget {
  final HomeController jsonController = Get.put(HomeController());

  TestJsonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JSON Files')),
      body: Obx(() {
        if (jsonController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (jsonController.jsonFilesPaths.isEmpty) {
          return Center(child: Text('Нет JSON файлов в assets/json'));
        } else {
          return ListView.builder(
            itemCount: jsonController.jsonFilesPaths.length,
            itemBuilder: (context, index) {
              final filePath = jsonController.jsonFilesPaths[index];
              return ListTile(
                title: Text('Файл: ${filePath.split('/').last}'),
                subtitle: Text('Путь: $filePath'),
              );
            },
          );
        }
      }),
    );
  }
}