import 'dart:convert';

class CreateEventResponseViewModel {
  String? id;
  String? name;
  String? start;
  String? end;

  CreateEventResponseViewModel({this.id, this.name, this.start, this.end});

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "start": start, "end": end};
  factory CreateEventResponseViewModel.fromJson(String res) {
    final json = jsonDecode(res);
    return CreateEventResponseViewModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      start: json['start'] as String?,
      end: json['end'] as String?,
    );
  }
}
