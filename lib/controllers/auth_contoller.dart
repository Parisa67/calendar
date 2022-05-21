import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  TextEditingController? textController1;
  TextEditingController? textController2;
  TextEditingController? textController3;
  TextEditingController? textController4;
  String token ="";

  
 
  @override
  void onInit() {
 textController1=TextEditingController();
 textController2=TextEditingController();
 textController3=TextEditingController();
 textController4=TextEditingController();
//  subTitle=TextEditingController();
    super.onInit();
  }
}