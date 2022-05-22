import 'package:calendar/models/error_view_model.dart';

class ResponseViewModel<T> {
  T? response;
  ErrorViewModel? error;
  ResponseViewModel({this.error, this.response});
}
