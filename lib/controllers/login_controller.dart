import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/auth_page.dart';

class LoginController extends GetxController {
  TextEditingController? textController;

  RxBool showError = false.obs;
  // RxBool loading = false.obs;
  RxString key = "".obs;
  @override
  void onInit() {
    textController = TextEditingController();

    super.onInit();
  }
}
