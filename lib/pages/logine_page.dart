import 'package:calendar/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/loding_controller.dart';
import '../controllers/login_controller.dart';
import '../models/login_resquest_view_model.dart';
import '../services/login_servise.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                const Text(
                  "لطفا شماره‌ی تلفن همراه خود را وارد کنید.",
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 48.0, bottom: 24),
                    child: Obx(() => TextField(
                        controller: Get.find<LoginController>().textController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: blackColor, fontSize: 14),
                        // textDirection: TextDirection.ltr,

                        decoration: InputDecoration(
                          fillColor: backgroundTextFieldColor,
                          filled: true,
                          hintStyle:
                              const TextStyle(color: blackColor, fontSize: 12),
                          labelText: "مثال: 09365464787",
                          labelStyle:
                              const TextStyle(color: grayColor, fontSize: 14),
                          errorText: Get.find<LoginController>().showError.value
                              ? " *شماره‌ی تلفن همراه صحیح نمی باشد"
                              : null,
                          errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: redColor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: borderColor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: borderColor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: redColor, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        )))),
                GestureDetector(
                  onTap: () async {
                    login(context);
                  },
                  child: Obx(() => Container(
                      width: Get.width,
                      height: 55,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff4CC9F0),
                                Color(0xff4361EE),
                                Color(0xff3A0CA3),
                              ])),
                      child: Get.find<LoadingController>().loading.value
                          ? const Padding(
                              padding: EdgeInsets.only(
                                  left: 150, right: 150, top: 10, bottom: 10),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                                color: Colors.white,
                              ),
                            )
                          : const Center(
                              child: Text(
                                "ارسال",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool validPhoneNumber(String text) {
    if (text == "" ||
        text.length != 11 ||
        !(RegExp(r"^09[0-9]{9}").hasMatch(text))) {
      return false;
    } else {
      return true;
    }
  }

  void login(BuildContext context) async {
    if (Get.find<LoadingController>().loading.value) {
    } else {
      FocusScope.of(context).unfocus();
      bool isValid =
          validPhoneNumber(Get.find<LoginController>().textController!.text);
      LoginRequestViewModel loginRequestViewModel = LoginRequestViewModel(
          username: Get.find<LoginController>().textController!.text);
      if (!isValid) {
        Get.find<LoginController>().showError.value = true;
      } else {
        try {
          Get.find<LoginController>().showError.value = false;
          Get.find<LoadingController>().loading.value = true;
          var response = await LoginServise().login(loginRequestViewModel);
          Get.find<LoginController>().key.value = response!.response!.key!;
          Get.find<LoadingController>().loading.value = false;
          Get.toNamed("/AuthPage");
        } catch (e) {
          Get.snackbar("خطا", "پاسخی از سمت سرور دربافت نشد");
        } finally {
          Get.find<LoginController>().showError.value = false;
          Get.find<LoadingController>().loading.value = false;
        }
      }
    }
  }
}
