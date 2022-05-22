import 'package:calendar/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_contoller.dart';
import '../controllers/loding_controller.dart';
import '../controllers/login_controller.dart';
import '../main.dart';
import '../models/verify_request_view_model.dart';
import '../services/login_servise.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);
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
              // textDirection:TextDirection.rtl,/
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            const TextSpan(
                              text: "کد چهار رقمی ارسال شده به شماره‌ی  ",
                              style: TextStyle(fontSize: 16, color: blackColor),
                            ),
                            TextSpan(
                              text: Get.find<LoginController>()
                                  .textController!
                                  .text,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.blue),
                            ),
                            const TextSpan(
                              text: " را وارد کنید.",
                              style: TextStyle(fontSize: 16, color: blackColor),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 32, right: 32,),
                  child: Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textField(
                        Get.find<AuthController>().textController1!,
                      ),
                      textField(
                        Get.find<AuthController>().textController2!,
                      ),
                      textField(
                        Get.find<AuthController>().textController3!,
                      ),
                      textField(
                        Get.find<AuthController>().textController4!,
                      ),
                    ],
                  ),
                ),
            Obx(()=>  Visibility(
                    visible: Get.find<AuthController>().showWarning.value,
                    child:Row(
                      children:const [
                         Padding(padding: EdgeInsets.only(top:10,bottom: 10,right: 32),
                        child:Text("*کد ورودی اشتباه میباشد. " ,style: TextStyle(fontSize: 16, color: redColor),)
                        ),
                      ],
                    ),
                  )),
               
                Padding(
                  padding:  const EdgeInsets.only(top: 24),
                  child: GestureDetector(
                    onTap: () async {
                      if (Get.find<LoadingController>().loading.value) {
                      } else {
                        auth(context);
                      }
                    },
                    child: Obx(() => Container(
                        width: Get.width,
                        height: 55,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                //     stops: [
                                //   0.2,
                                //   0.6,
                                //   0.99,
                                // ],
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textField(
    TextEditingController controller,
//  TextInputAction? textInputAction,Function onSubmit
  ) {
    return SizedBox(
      width: 45,
      child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          // textInputAction: textInputAction,
          // onSubmitted: (_){onSubmit;},
          style: const TextStyle(color: blackColor, fontSize: 14),
          // textDirection: TextDirection.ltr,
          maxLength: 1,
          decoration: const InputDecoration(
            fillColor: backgroundTextFieldColor,
            filled: true,
            counterText: "",
            hintText: '0',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: redColor, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(30))),
          )),
    );
  }

  void auth(BuildContext context) async {
    FocusScope.of(context).unfocus();
    Get.find<AuthController>().showWarning.value=false;
    String tx1 = Get.find<AuthController>().textController1!.text;
    String tx2 = Get.find<AuthController>().textController2!.text;
    String tx3 = Get.find<AuthController>().textController3!.text;
    String tx4 = Get.find<AuthController>().textController4!.text;

    try {
      if (tx1 != "" && tx2 != "" && tx3 != "" && tx4 != "") {
        int code = int.parse(tx1 + tx2 + tx3 + tx4);
        Get.find<LoadingController>().loading.value = true;

        VerifyRequestViewModel verifyRequest = VerifyRequestViewModel(
            username: Get.find<LoginController>().textController!.text,
            key: Get.find<LoginController>().key.value,
            otp: code);
        var response = await LoginServise().authorization(verifyRequest);
        if (response!.error != null) {
         
          if(response.error!.message!.contains('Otp is not valid.')){
Get.find<AuthController>().showWarning.value=true;
          }else{
          Get.snackbar("هشدار", response.error!.message!);

          }
          
          Get.find<AuthController>().textController1!.text = "";
          Get.find<AuthController>().textController2!.text = "";
          Get.find<AuthController>().textController3!.text = "";
          Get.find<AuthController>().textController4!.text = "";
        } else {
          localStorage.write('token', response.response!.token!);
          // Get.find<AuthController>().token = response.response!.token!;
          Get.find<LoadingController>().loading.value = false;
          Get.offAllNamed("/CalendarPage");
        }
      } else {
        Get.snackbar("هشدار", "کد را به صورت کامل وارد کنید!");
      }
    } catch (e) {
      // if(e.statusCode)
      Get.snackbar("خطا", "پاسخی از سمت سرور دریافت نشد.");
    } finally {
      Get.find<LoadingController>().loading.value = false;
    }
  }
}
