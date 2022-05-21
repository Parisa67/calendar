class TimeViewModel {
  int? hour;
  int? minute;
  TimeViewModel({this.hour, this.minute});
  String getTime({int? realMinute}) {
    return "${get2Digit(hour == 0 ? 12 : (hour! > 12 ? hour! - 12 : hour!))}:${get2Digit(realMinute ?? minute!)}";
  }

  String getAPM() {
    if (hour! < 12) {
      return "ق.ظ";
    } else if (hour == 12) {
      return "ظ";
    }
    return "ب.ظ";
  }

  get2Digit(int i) {
    if (i < 10) {
      return "0$i";
    }
    return "$i";
  }
}
