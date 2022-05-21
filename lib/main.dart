import 'package:calendar/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'bindings/binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

String get iranSanFont => 'IranSans';
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates:const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales:const [
          Locale("fa", "IR"),
        ],
      locale:const Locale("fa", "IR"),
      theme: ThemeData(
          fontFamily: iranSanFont,
        ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.pages ,
      initialBinding: Binding(),
      initialRoute: '/CalendarPage',
    );
  }
}

