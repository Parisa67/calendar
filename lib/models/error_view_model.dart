import 'dart:convert';

class ErrorViewModel{
  String? error;
  int? code;
  String? message;
  ErrorViewModel({this.code,this.error,this.message});

  factory ErrorViewModel.fromJson(String res) {
    final json = jsonDecode(res);
     return ErrorViewModel(
       
       error:json['error']as String?,
       code:json['code']as int?,
       message:json['message']as String?
     );
}
}