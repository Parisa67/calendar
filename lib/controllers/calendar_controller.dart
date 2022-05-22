import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../models/event_view_model.dart';
import '../models/time_view_model.dart';

class CalendarController extends GetxController {
  String dayName = "";
  String date = Jalali.now().year.toString() +
      "/" +
      Jalali.now().month.toString() +
      "/" +
      Jalali.now().day.toString();
  RxList<EventViewModel> dailyEvents = <EventViewModel>[].obs;
  RxBool justShow = true.obs;

  @override
  void onInit() {
    format1(Jalali.now().weekDay);

    super.onInit();
  }

  void format1(int day) {
    switch (day) {
      case 0:
        dayName = "شنبه";
        break;
      case 1:
        dayName = "یک شنبه";
        break;
      case 2:
        dayName = "شنبه";
        break;
      case 3:
        dayName = "دو شنبه";
        break;
      case 4:
        dayName = "سه شنبه";
        break;
      case 5:
        dayName = "چهار شنبه";
        break;
      case 6:
        dayName = "پنج شنبه";
        break;
      case 7:
        dayName = "جمعه";
        break;
    }
  }

  void addDailyEvents(value) {
    Get.find<CalendarController>().dailyEvents.add(
          EventViewModel(
              start: TimeViewModel(
                  hour: DateTime.parse(value.response.start).toLocal().hour,
                  minute: DateTime.parse(value.response.start).toLocal().minute),
              end: TimeViewModel(
                  hour: DateTime.parse(value.response.end).toLocal().hour,
                  minute: DateTime.parse(value.response.end).toLocal().minute),
              title: value.response.name),
        );
    update();
  }
}
