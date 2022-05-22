import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class EventNew extends GetxController {
  TextEditingController? eventNameController;
  RxBool activeButton = false.obs;
  RxInt hour = 0.obs;
  RxInt minute = 0.obs;
  RxInt duration = 15.obs;

  @override
  void onInit() {
    eventNameController = TextEditingController();

    super.onInit();
  }
}
