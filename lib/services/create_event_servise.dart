import 'dart:convert';
import 'package:calendar/models/error_view_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/auth_contoller.dart';
import '../models/create_request_view_model.dart';
import '../models/create_responses_view_model.dart';
import '../models/response_view_model.dart';

class CreateEvent{


String? serverAddress = "https://challenge.reval.me/v1/calendar/create";
   Map<String, String>? headers = {
        'Authorization' : 'Bearer '+ Get.find<AuthController>().token,
        'Content-Type': 'application/json',
        'Accept' :'*/*',
        'Accept-Encoding':'gzip, deflate, br',
        'Connection':'keep-alive'
      }; 
 Future<ResponseViewModel<CreateEventResponseViewModel>?> createEvent(CreateEventRequestViewModel loginViewModel) async {
    var client = http.Client();
    try {
    
      var json = jsonEncode(loginViewModel.toJson());
      var uriResponse = await client
          .post(
            Uri.parse(serverAddress!),
            headers: headers,
            body: json,
          )
          .timeout(const Duration(seconds: 60));
         
      if (uriResponse.statusCode == 200) {
        var body = utf8.decode(uriResponse.bodyBytes);
          var res = CreateEventResponseViewModel.fromJson(
            body);
        return   ResponseViewModel(response:res);
      }else{
        var body = utf8.decode(uriResponse.bodyBytes);
        var res = ErrorViewModel.fromJson(
            body);
      return  ResponseViewModel(error:res);
       }
    } catch (ex) {
   
      rethrow ;
    } finally {
      client.close();
    }
  }}