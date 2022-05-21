import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';
import '../../controllers/event_new_controller.dart';
import '../../enum.dart';

class Carousel extends StatelessWidget {
  int? end;
  int? activeNumber;
  TypeTime? type;
  Carousel({@required this.end,@required this.activeNumber,@required this.type, Key? key}) : super(key: key);
List <int> listNumber=[];
  @override
  Widget build(BuildContext context) {
  
    var index = activeNumber;
    listNumber= List<int>.generate(
        end!,
        (i) => i );
    return Swiper(
      itemBuilder: (BuildContext context, int ind) {
        return Center(
            child: Text(listNumber[ind].toString(),
                style: TextStyle(
                    fontSize: 20,
                    color: index == listNumber[ind] ? blueColor : borderColor)));
      },
      onIndexChanged: (int i) => {index = i,
      if(type==TypeTime.hour){
        Get.find<EventNew>().hour.value=i
      } 
      else if(type==TypeTime.minute){
 Get.find<EventNew>().minute.value=i
      }else if(type==TypeTime.duration){
 Get.find<EventNew>().duration.value=i
      }
      
      },
      index: index,
      itemCount: listNumber.length,
      scrollDirection: Axis.horizontal,
      axisDirection: AxisDirection.right,
      viewportFraction: 0.28,
      scale: 0.2,
      control:const SwiperControl(
        size: 20.0,
      ),
    );
  }
}
