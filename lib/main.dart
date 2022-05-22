import 'package:calendar/route/route.dart';
import 'package:calendar/services/grpc/generated/google/protobuf/empty.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grpc/grpc.dart';

import 'bindings/binding.dart';
import 'services/grpc/generated/calendar.pbgrpc.dart';

void main() async {
  await GetStorage.init();
  final channel = ClientChannel(
    'challenge.reval.me',
    port: 443,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = CalendarClient(channel);

  try {
    final responses = stub
        .listenForEvents(
      Empty(),
      options: CallOptions(compression: const GzipCodec()),
    )
        .listen((value) {
      print(value.name);
    });
    print("somthing");
  } catch (e) {
    print('Caught error: $e');
  }
  runApp(const MyApp());
}

final localStorage = GetStorage();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  String get iranSanFont => 'IranSans';
  @override
  Widget build(BuildContext context) {
    var token = localStorage.read('token');

    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"),
      ],
      locale: const Locale("fa", "IR"),
      theme: ThemeData(
        fontFamily: iranSanFont,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Routes.pages,
      initialBinding: Binding(),
      initialRoute: token != null ? '/CalendarPage' : '/LoginPage',
    );
  }
}
