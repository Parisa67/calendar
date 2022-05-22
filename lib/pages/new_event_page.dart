import 'package:calendar/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/calendar_controller.dart';
import '../controllers/event_new_controller.dart';
import '../controllers/loding_controller.dart';
import '../models/create_request_view_model.dart';
import '../services/create_event_servise.dart';
import 'custumeWidget/carousel.dart';
import '../../enum.dart';

class NewEventPage extends StatelessWidget {
  NewEventPage({
    Key? key,
  }) : super(key: key);
// TimeViewModel? time = Get.find<EventNew>().argumentData[0];
  @override
  Widget build(BuildContext context) {
    print(Get.arguments[0].hour);
    return Scaffold(
        appBar: AppBar(
            elevation: 1.5,
            backgroundColor: whiteColor,
            centerTitle: true,
            title: const Text(
              "رویداد جدید",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: blackColor,
                ))),
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: borderBoxColor, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: whiteColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 7),
                            child: Text("نام رویداد",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          TextField(
                              controller:
                                  Get.find<EventNew>().eventNameController,
                              onChanged: (value) {
                                if (Get.find<EventNew>()
                                        .eventNameController!
                                        .text !=
                                    "") {
                                  Get.find<EventNew>().activeButton.value =
                                      true;
                                } else {
                                  Get.find<EventNew>().activeButton.value =
                                      false;
                                }
                              },
                              style: const TextStyle(
                                  color: blackColor, fontSize: 14),
                              decoration: const InputDecoration(
                                fillColor: whiteColor,
                                filled: true,
                                hintStyle:
                                    TextStyle(color: grayColor, fontSize: 12),
                                hintText: "مثال: جشن نوروز",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: borderBoxColor, width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: borderBoxColor, width: 1.5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ))
                        ]),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: borderBoxColor, width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text("زمان رویداد",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("دقیقه",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: grayColor,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: borderColor, width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        width: 118,
                                        height: 40,
                                        child: Carousel(
                                          end: 69,
                                          activeNumber: Get.arguments[0].minute,
                                          type: TypeTime.minute,
                                        ))
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 18.0),
                                  child: Text(":",
                                      style: TextStyle(
                                          fontSize: 20, color: grayColor)),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("ساعت",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: grayColor,
                                            fontWeight: FontWeight.w600)),
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: borderColor, width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        width: 118,
                                        height: 40,
                                        child: Carousel(
                                          end: 24,
                                          activeNumber: (Get.arguments[0].hour),
                                          type: TypeTime.hour,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20, top: 20),
                              child: Text("مدت زمان رویداد(دقیقه)",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: borderColor, width: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: 118,
                                height: 40,
                                child: Carousel(
                                  end: 240,
                                  activeNumber: 15,
                                  type: TypeTime.duration,
                                ))
                          ]),
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<EventNew>().activeButton.value
                          ? addEvent(context)
                          : () {};
                    },
                    child: Obx(
                      () => Container(
                        width: Get.width,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Get.find<EventNew>().activeButton.value
                                ? activeButtomColor
                                : deActiveButtomColor),
                        child: Get.find<LoadingController>().loading.value
                            ? const Padding(
                                padding: EdgeInsets.only(
                                    left: 170, right: 170, top: 10, bottom: 10),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                  color: Colors.white,
                                ),
                              )
                            : const Center(
                                child: Text("ثبت",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600)),
                              ),
                      ),
                    ),
                  ))
            ],
          )),
        ));
  }

  void addEvent(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      Get.find<LoadingController>().loading.value = true;
      DateTime startDateTemp = DateTime.now();
      DateTime startDate = DateTime(
          startDateTemp.year,
          startDateTemp.month,
          startDateTemp.day,
          Get.find<EventNew>().hour.value,
          Get.find<EventNew>().minute.value,
          startDateTemp.second,
          startDateTemp.millisecond,
          startDateTemp.microsecond);

      if(Get.find<EventNew>().hour.value==23 && Get.find<EventNew>().duration.value>59){
        Get.find<EventNew>().duration.value=59;
      }
      DateTime endDate =
          startDate.add(Duration(minutes: Get.find<EventNew>().duration.value));
      CreateEventRequestViewModel createRequest = CreateEventRequestViewModel(
        name: Get.find<EventNew>().eventNameController!.text,
        
        start: startDate.toUtc().toString().replaceAll(" ", "T"),
        end: endDate.toUtc().toString().replaceAll(" ", "T"),
      );

    bool isValid=true;
    if(Get.find<CalendarController>().dailyEvents.isNotEmpty){
var newStart =(Get.find<EventNew>().hour.value * 60) + Get.find<EventNew>().minute.value;
    var newEnd =(endDate.hour*60)+endDate.minute;
   
        for( var item in Get.find<CalendarController>().dailyEvents){
         var start =(item.start!.hour!*60)+item.start!.minute!;
         var end =(item.end!.hour!*60)+item.end!.minute!;
      
          if(newStart>=start || newEnd<=end){
            isValid=false;
           
          }
       
        }
       
        }
       
        if(isValid){
        var response = await CreateEvent().createEvent(createRequest);
      if (response!.error != null) {
        Get.snackbar("هشدار", response.error!.message!);
      } else {
          Get.find<CalendarController>().justShow.value=true;
        Get.find<EventNew>().eventNameController!.text = "";
        Get.find<CalendarController>().addDailyEvents(response);
        Get.find<EventNew>().activeButton.value=false;
        Get.back(result: response);
        // Get.back();
      }

        }else{
          Get.snackbar("خطا", " رویداد جدید با رویدادهای دیگر همپوشانی دارد ساعت را دوباره تنظیم کنید");
          return;
      

        }
         

       
       



      //
    } catch (e) {
      Get.snackbar("خطا", "پاسخی از سمت سرور دریافت نشد");
    } finally {
      Get.find<LoadingController>().loading.value = false;
    }
  }
}
