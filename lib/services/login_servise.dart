

import 'dart:convert';
import 'package:calendar/models/error_view_model.dart';
import 'package:http/http.dart' as http;

import '../models/login_responses_view_model.dart';
import '../models/login_resquest_view_model.dart';
import '../models/response_view_model.dart';
import '../models/verify_request_view_model.dart';
import '../models/verify_responses_view_model.dart';

class LoginServise{
  String? serverAddress = "https://challenge.reval.me/v1/auth/";
   Map<String, String>? headers = {
        'Content-Type': 'application/json',
      };

  Future<ResponseViewModel<LoginResponsesViewModel>?> login(LoginRequestViewModel loginViewModel) async {
    var client = http.Client();
    try {
    
      var json = jsonEncode(loginViewModel.toJson());
      var uriResponse = await client
          .post(
            Uri.parse(serverAddress! + 'login'),
            headers: headers,
            body: json,
          )
          .timeout(const Duration(seconds: 60));
         
      if (uriResponse.statusCode == 200) {
        var body = utf8.decode(uriResponse.bodyBytes);
          var res = LoginResponsesViewModel.fromJson(
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
  }

  Future<ResponseViewModel<VerifyResponsesViewModel>?> authorization(VerifyRequestViewModel verifyResponses) async {
    var client = http.Client();
    try {
    
      var json = jsonEncode(verifyResponses.toJson());
      var uriResponse = await client
          .post(
            Uri.parse(serverAddress! + 'verify'),
            headers: headers,
            body: json,
          )
          .timeout(const Duration(seconds: 120));
      
          
      if (uriResponse.statusCode == 200) {
        var body = utf8.decode(uriResponse.bodyBytes);

       var res = VerifyResponsesViewModel.fromJson(
            body);
          
       
        return  ResponseViewModel(response:res);
      }else{
         var body = utf8.decode(uriResponse.bodyBytes);
        var err = ErrorViewModel.fromJson(
            body);
       return ResponseViewModel(error:err);
      }
    } catch (ex) {
       rethrow ;
    } finally {
      client.close();
    }
  }
}