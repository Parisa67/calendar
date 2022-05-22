import 'dart:convert';

class CreateEventRequestViewModel {
  String? name;
  String? start;
  String? end;

  CreateEventRequestViewModel({this.name, this.start, this.end});

  Map<String, dynamic> toJson() => {"name": name, "start": start, "end": end};
  factory CreateEventRequestViewModel.fromJson(String res) {
    final json = jsonDecode(res);
    return CreateEventRequestViewModel(
      name: json['name'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
    );
  }
}
