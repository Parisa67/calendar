
import 'package:calendar/models/time_view_model.dart';
import 'package:get/state_manager.dart';

class DailyAgendaController extends GetxController{
    RxBool selectRow = false.obs;
    Rx<TimeViewModel>? time=TimeViewModel().obs;
}