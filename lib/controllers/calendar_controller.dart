
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarController extends GetxController{
  
    String dayName="";
    String date=Jalali.now().year.toString()+"/"+Jalali.now().month.toString()+"/"+Jalali.now().day.toString();
   

    @override
  void onInit() {
    format1(Jalali.now().weekDay);
   
    super.onInit();
  }
   void format1(int day) {
      
      switch(day){
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
  }