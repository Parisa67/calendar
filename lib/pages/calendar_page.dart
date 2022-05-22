import 'package:calendar/const.dart';
import 'package:calendar/models/event_view_model.dart';
import 'package:calendar/models/time_view_model.dart';
import 'package:calendar/pages/custumeWidget/daily_Agenda_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calendar_controller.dart';
import '../controllers/event_new_controller.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=> 
    Visibility(
      visible: Get.find<CalendarController>().justShow.value,
      child:
    Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Get.find<CalendarController>().dayName,
                      style: const TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(Get.find<CalendarController>().date,
                      style: const TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: DailyAgendaView(
                          onRowDoubleTap: (TimeViewModel time) {
                            Get.find<EventNew>().hour.value = time.hour!;
                            Get.find<EventNew>().minute.value = time.minute!;
                            Get.toNamed('/NewEventPage', arguments: [time]);
                          },
                          start: TimeViewModel(hour: 8, minute: 0),
                          end: TimeViewModel(hour: 23, minute: 59),
                          // dailyEvents: Get.find<CalendarController>().dailyEvents
                        ),
                      ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    )));
  }
}
