import 'package:calendar/models/time_view_model.dart';

class EventViewModel {
  TimeViewModel? start;
  TimeViewModel? end;
  String? title;
  EventViewModel({this.title, this.start, this.end});

  bool isNull() {
    return start == null;
  }

  bool timeIsInEvent(TimeViewModel rowTime) {
    var rts = rowTime.getMinuteOfDay();
    var rte = rowTime.getMinuteOfDay() + 15;

    var ets = start!.getMinuteOfDay();
    var ete = end!.getMinuteOfDay();

    return (startHalfBetween(ets, rts, rte) ||
        endHalfBetween(ete, rts, rte) ||
        openBetween(rts, ets, ete));
  }

  bool timeStartInEvent(TimeViewModel rowTime) {
    var rts = rowTime.getMinuteOfDay();
    var rte = rowTime.getMinuteOfDay() + 15;

    var ets = start!.getMinuteOfDay();
    var ete = end!.getMinuteOfDay();

    return startHalfBetween(((ets + ete) ~/ 2).toInt(), rts, rte);
  }

  int getOpenTimeInEvent() {
    return start!.getMinuteOfDay();
  }

  int getDurationTimeInEvent() {
    return end!.getMinuteOfDay() - start!.getMinuteOfDay();
  }

  bool startHalfBetween(int value, int openInterval, int closeInterval) {
    return value >= openInterval && value < closeInterval;
  }

  bool endHalfBetween(int value, int openInterval, int closeInterval) {
    return value > openInterval && value <= closeInterval;
  }

  bool openBetween(int value, int openInterval, int closeInterval) {
    return value > openInterval && value < closeInterval;
  }
}
