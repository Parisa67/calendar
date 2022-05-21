

import 'dart:convert';

class VerifyResponsesViewModel{
 
  
  String? token;
  
 
VerifyResponsesViewModel({this.token});

Map<String, dynamic> toJson() => {
  
  "token": token,

};
factory VerifyResponsesViewModel.fromJson(String res) {
    final json = jsonDecode(res);
     return VerifyResponsesViewModel(
       
       token:json['token']as String?,
     );
}

}