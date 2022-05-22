import 'dart:convert';

class VerifyRequestViewModel {
  String? username;
  String? key;
  int? otp;

  VerifyRequestViewModel({
    this.username,
    this.key,
    this.otp,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "key": key,
        "otp": otp,
      };
  factory VerifyRequestViewModel.fromJson(String res) {
    final json = jsonDecode(res);
    return VerifyRequestViewModel(
      username: json['username'] as String?,
      key: json['key'] as String?,
      otp: json['otp'] as int?,
    );
  }
}
