import 'package:calendar/models/event_view_model.dart';
import 'package:calendar/models/time_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controllers/calendar_controller.dart';
import '../../controllers/daily_agenda.controller.dart';
import '../../models/event_view_model.dart';

class DailyAgendaView extends StatelessWidget {
  TimeViewModel? start = TimeViewModel(hour: 8, minute: 0);
  TimeViewModel? end = TimeViewModel(hour: 23, minute: 59);
  // List<EventViewModel>? dailyEvents = <EventViewModel>[];

  DailyAgendaView({Key? key, this.start, this.end, this.onRowDoubleTap})
      : super(key: key);

  double rowHeight = 24;

  final DailyAgendaRowDoubleTapCallback? onRowDoubleTap;
  @override
  Widget build(BuildContext context) {
    var nowTime = DateTime.now();
    var agendaHeight = (end!.getMinuteOfDay() - start!.getMinuteOfDay());

    var hourlyContainers = Column(
      children: [
        hourlyContainer(
            nowTime, TimeViewModel(hour: start!.hour!, minute: 0), true),
      ],
    );

    var startIndex = start!.hour! + 1;

    for (var i = startIndex; i <= end!.hour!; i++) {
      var time = TimeViewModel(hour: i, minute: 0);
      hourlyContainers.children.add(hourlyContainer(nowTime, time, false));
    }
    var stack = Stack(
      children: [hourlyContainers],
    );
     
    return Obx(() {
 for (var dailyEvent in Get.find<CalendarController>().dailyEvents) {
        stack.children.add(getExistsEvent(dailyEvent));
      }
      return stack;
    });
  }

  Positioned getExistsEvent(EventViewModel dailyEvent) {
    return Positioned(
        top: ((dailyEvent.getOpenTimeInEvent() - start!.getMinuteOfDay()) *
                rowHeight) /
            15,
        right: 57,
        child: Container(
          width: Get.width - 59,
          height: (dailyEvent.getDurationTimeInEvent() * rowHeight) / 15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: darkBlueColor,
          ),
          child: Center(
            child: ((((dailyEvent.getDurationTimeInEvent() * rowHeight) / 24)) >
                    rowHeight)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${dailyEvent.title!}\n${dailyEvent.start!.getTime()} تا ${dailyEvent.end!.getTime()} ${dailyEvent.end!.getAPM()}",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style:
                              const TextStyle(color: whiteColor, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  )
                :Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  text(dailyEvent.title!),
                  text("  -${dailyEvent.start!.getTime()} تا ${dailyEvent.end!.getTime()} ${dailyEvent.end!.getAPM()}"),
                    
                ],) 
          ),
        ));
  }

  Text text(String dailyEvent) {
    return Text(
                  dailyEvent ,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(color: whiteColor, fontSize: 14));
  }

  Widget hourlyContainer(
      DateTime? nowTime, TimeViewModel time, bool? firstRow) {
    int? minute;
    int minuteRow = -1;
    if (nowTime!.hour == time.hour!) {
      minute = nowTime.minute;
    }
    var row0 = container(time,
        title: time.getTime(),
        widthbottom: 0.5,
        widthtop: 1.0,
        firstRow: firstRow);
    var row1 = container(TimeViewModel(hour: time.hour, minute: 15),
        title: time.getAPM(), widthbottom: 0.0, widthtop: 0.0);
    var row2 = container(TimeViewModel(hour: time.hour, minute: 30),
        widthbottom: 0.5, widthtop: 0.5);
    var row3 = container(TimeViewModel(hour: time.hour, minute: 45),
        widthbottom: 1.0, widthtop: 0.0);

    if (minute != null) minuteRow = (minute ~/ 15).toInt();

    switch (minuteRow) {
      case 0:
        row0 = container(time,
            title: time.getTime(realMinute: minute),
            minute: minute,
            widthbottom: 0.5,
            widthtop: 1.0,
            firstRow: firstRow);
        break;
      case 1:
        row1 = container(TimeViewModel(hour: time.hour, minute: 15),
            title: time.getTime(realMinute: minute),
            minute: minute,
            widthbottom: 0.0,
            widthtop: 0.0);
        row2 = container(TimeViewModel(hour: time.hour, minute: 30),
            title: time.getAPM(), widthbottom: 0.5, widthtop: 0.5);
        break;
      case 2:
        row2 = container(TimeViewModel(hour: time.hour, minute: 30),
            title: time.getTime(realMinute: minute),
            minute: minute,
            widthbottom: 0.5,
            widthtop: 0.5);
        break;
      case 3:
        row3 = container(TimeViewModel(hour: time.hour, minute: 45),
            title: time.getTime(realMinute: minute),
            minute: minute,
            widthbottom: 1.0,
            widthtop: 0.0);
        break;
      default:
    }

    return Column(
      children: [
        row0,
        row1,
        row2,
        row3,
      ],
    );
  }

  Widget container(TimeViewModel timeForTap,
      {String? title,
      double? widthtop,
      double? widthbottom,
      bool? firstRow = false,
      double? widthRight = 1,
      double? widthleft = 2,
      Color color = whiteColor,
      int? minute}) {
    return GestureDetector(
      onTap: () {
        if (Get.find<DailyAgendaController>().selectRow.value &&
            Get.find<DailyAgendaController>().time!.value.hour ==
                timeForTap.hour &&
            Get.find<DailyAgendaController>().time!.value.minute ==
                timeForTap.minute) {
          onRowDoubleTap!(timeForTap);
          Get.find<DailyAgendaController>().selectRow.value = false;
          Get.find<DailyAgendaController>().time!.value = TimeViewModel();
        } else {
          Get.find<DailyAgendaController>().time!.value = timeForTap;
          Get.find<DailyAgendaController>().selectRow.value = true;
        }
      },
      child: Stack(
        children: [
          Row(
            children: [
              boxTime(title, minute: minute),
              Obx(() => Expanded(
                    child: Container(
                        width: Get.width,
                        height: rowHeight,
                        decoration: firstRow!
                            ? BoxDecoration(
                                color: whiteColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20)),
                                border: Border.all(
                                    color: borderBoxColor, width: 0.5),
                              )
                            : BoxDecoration(
                                color: color,
                                border: Border(
                                  top: BorderSide(
                                      width: widthtop!, color: borderBoxColor),
                                  bottom: BorderSide(
                                      width: widthbottom!,
                                      color: borderBoxColor),
                                  right: BorderSide(
                                      width: widthRight!,
                                      color: borderBoxColor),
                                  left: BorderSide(
                                      width: widthleft!, color: borderBoxColor),
                                ),
                              ),
                        child: Get.find<DailyAgendaController>()
                                    .selectRow
                                    .value &&
                                Get.find<DailyAgendaController>()
                                        .time!
                                        .value
                                        .hour ==
                                    timeForTap.hour &&
                                Get.find<DailyAgendaController>()
                                        .time!
                                        .value
                                        .minute ==
                                    timeForTap.minute
                            ? Container(
                                padding: const EdgeInsets.only(left: 3.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: backgroundTextFieldColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.add,
                                      color: iconColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox()),
                  ))
            ],
          ),
          minute != null
              ? Positioned(
                  top: (minute % 15 * rowHeight) / 15,
                  right: 53,
                  child: Container(
                    width: Get.width,
                    height: 1,
                    decoration: const BoxDecoration(
                      // color: borderColor,
                      border: Border(
                        top: BorderSide(width: 2, color: borderColor),
                      ),
                    ),
                  ))
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget boxTime(String? title, {String subTitle = "", int? minute}) {
    Color colorBorder = minute != null ? borderColor : Colors.transparent;
    return Container(
        width: 55,
        height: rowHeight,
        padding: const EdgeInsets.only(right: 6.0, left: 6),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: colorBorder, width: 2),
        ),
        child: Text(title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: grayColor, fontSize: 15)));
  }
}

typedef DailyAgendaRowDoubleTapCallback = void Function(TimeViewModel details);
