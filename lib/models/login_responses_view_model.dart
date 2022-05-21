

import 'dart:convert';

class LoginResponsesViewModel{
 
  
  String? key;
  
 
LoginResponsesViewModel({this.key});

Map<String, dynamic> toJson() => {
  
  "key": key,

};
factory LoginResponsesViewModel.fromJson(String res) {
    final json = jsonDecode(res);
     return LoginResponsesViewModel(
       
       key:json['key']as String?,
     );
}

}