import 'package:get/get.dart';

import '../controllers/auth_contoller.dart';
import '../controllers/calendar_controller.dart';
import '../controllers/daily_agenda.controller.dart';
import '../controllers/event_new_controller.dart';
import '../controllers/loding_controller.dart';
import '../controllers/login_controller.dart';
class Binding extends Bindings{
  @override
  void dependencies() {
   
   Get.put(LoginController());
   Get.lazyPut(()=>AuthController());
   Get.put(LoadingController());
   Get.put(CalendarController());
   Get.put(EventNew());
   Get.lazyPut(()=>DailyAgendaController());
  }

}