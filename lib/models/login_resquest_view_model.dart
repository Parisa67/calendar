import 'dart:convert';

class LoginRequestViewModel {
  String? username;

  LoginRequestViewModel({this.username});

  Map<String, dynamic> toJson() => {
        "username": username,
      };
  factory LoginRequestViewModel.fromJson(String res) {
    final json = jsonDecode(res);
    return LoginRequestViewModel(
      username: json['username'] as String?,
    );
  }
}
