


import 'package:get/get.dart';


import '../pages/auth_page.dart';
import '../pages/calendar_page.dart';
import '../pages/logine_page.dart';
import '../pages/new_event_page.dart';

class Routes{
 static List<GetPage> get pages =>[
   GetPage(name: '/LoginPage', page:()=> LoginPage()),
   GetPage(name: '/AuthPage', page:()=>const AuthPage()),
   GetPage(name: '/CalendarPage', page:()=>const CalendarPage()),
   GetPage(name: '/NewEventPage', page:()=> NewEventPage()),

 ];

}