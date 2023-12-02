class MyLocalizations {
  static final MyLocalizations _instance = MyLocalizations._internal();

  factory MyLocalizations() {
    return _instance;
  }

  MyLocalizations._internal();

  static DateTime parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    return DateTime(2000, 1, 1, hour, minute);
  }
}
