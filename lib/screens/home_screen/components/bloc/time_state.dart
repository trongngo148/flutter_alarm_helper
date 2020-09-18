abstract class TimeState {
  final DateTime currentTime;
  final DateTime timeCustom;
  final int timeFallInSleep;
  final String result3h;
  final String result4h30;
  final String result6h;
  final String result7h30;
  final String period3h;
  final String period4h30;
  final String period6h;
  final String period7h30;
  final String result3hCustom;
  final String result4h30Custom;
  final String result6hCustom;
  final String result7h30Custom;
  final String period3hCustom;
  final String period4h30Custom;
  final String period6hCustom;
  final String period7h30Custom;

  TimeState(
      this.currentTime,
      this.timeCustom,
      this.timeFallInSleep,
      this.result3h,
      this.result4h30,
      this.result6h,
      this.result7h30,
      this.period3h,
      this.period4h30,
      this.period6h,
      this.period7h30,
      this.result3hCustom,
      this.result4h30Custom,
      this.result6hCustom,
      this.result7h30Custom,
      this.period3hCustom,
      this.period4h30Custom,
      this.period6hCustom,
      this.period7h30Custom);

  // String get getResult3h => result3h;
  // String get getResult4h30 => result4h30;
  // String get getResult6h => result6h;
  // String get getResult7h30 => result7h30;
  // String get getResult3hCustom => result3hCustom;
  // String get getResult4h30Custom => result4h30Custom;
  // String get getResult6hCustom => result6hCustom;
  // String get getResult7h30Custom => result7h30Custom;
  DateTime get getTimeCustom => timeCustom;
}

class InitialStateTime extends TimeState {
  InitialStateTime(
      {DateTime currentTime,
      DateTime timeCustom,
      int timeFallInSleep,
      String result3h,
      String result4h30,
      String result6h,
      String result7h30,
      String period3h,
      String period4h30,
      String period6h,
      String period7h30,
      String result3hCustom,
      String result4h30Custom,
      String result6hCustom,
      String result7h30Custom,
      String period3hCustom,
      String period4h30Custom,
      String period6hCustom,
      String period7h30Custom})
      : super(
            currentTime,
            timeCustom,
            timeFallInSleep,
            result3h,
            result4h30,
            result6h,
            result7h30,
            period3h,
            period4h30,
            period6h,
            period7h30,
            result3hCustom,
            result4h30Custom,
            result6hCustom,
            result7h30Custom,
            period3hCustom,
            period4h30Custom,
            period6hCustom,
            period7h30Custom);

  InitialStateTime getInit() {
    return InitialStateTime(
      currentTime: null,
      timeCustom: null,
      timeFallInSleep: 0,
      result3h: "",
      result4h30: "",
      result6h: "",
      result7h30: "",
    );
  }
}

class SuggestTime extends TimeState {
  SuggestTime(
      {DateTime currentTime,
      DateTime timeCustom,
      int timeFallInSleep,
      String result3h,
      String result4h30,
      String result6h,
      String result7h30,
      String period3h,
      String period4h30,
      String period6h,
      String period7h30,
      String result3hCustom,
      String result4h30Custom,
      String result6hCustom,
      String result7h30Custom,
      String period3hCustom,
      String period4h30Custom,
      String period6hCustom,
      String period7h30Custom})
      : super(
            currentTime,
            timeCustom,
            timeFallInSleep,
            result3h,
            result4h30,
            result6h,
            result7h30,
            period3h,
            period4h30,
            period6h,
            period7h30,
            result3hCustom,
            result4h30Custom,
            result6hCustom,
            result7h30Custom,
            period3hCustom,
            period4h30Custom,
            period6hCustom,
            period7h30Custom);

  String getPeriod(
      {DateTime time, int fallInSleep, int hourSleep, int minuteSleep}) {
    return time != null
        ? time
                    .add(Duration(
                        minutes: fallInSleep + minuteSleep, hours: hourSleep))
                    .hour >=
                12
            ? "PM"
            : "AM"
        : "";
  }

  String getTimeSuggest(
      {DateTime time, int fallInSleep, int hourSleep, int minuteSleep}) {
    return time != null
        ? "${time.add(Duration(minutes: fallInSleep + minuteSleep, hours: hourSleep)).hour}:${time.add(Duration(minutes: fallInSleep + minuteSleep, hours: hourSleep)).minute}"
        : "";
  }

  SuggestTime getTime() {
    return SuggestTime(
      currentTime: currentTime,
      timeCustom: timeCustom,
      timeFallInSleep: timeFallInSleep,
      result3h: getTimeSuggest(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 3,
          minuteSleep: 0),
      period3h: getPeriod(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 3,
          minuteSleep: 0),
      result4h30: getTimeSuggest(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 4,
          minuteSleep: 30),
      period4h30: getPeriod(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 4,
          minuteSleep: 30),
      result6h: getTimeSuggest(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 6,
          minuteSleep: 0),
      period6h: getPeriod(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 6,
          minuteSleep: 0),
      result7h30: getTimeSuggest(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 7,
          minuteSleep: 30),
      period7h30: getPeriod(
          time: currentTime,
          fallInSleep: timeFallInSleep,
          hourSleep: 7,
          minuteSleep: 30),
      result3hCustom: getTimeSuggest(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 3,
          minuteSleep: 0),
      period3hCustom: getPeriod(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 3,
          minuteSleep: 0),
      result4h30Custom: getTimeSuggest(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 4,
          minuteSleep: 30),
      period4h30Custom: getPeriod(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 4,
          minuteSleep: 30),
      result6hCustom: getTimeSuggest(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 6,
          minuteSleep: 0),
      period6hCustom: getPeriod(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 6,
          minuteSleep: 0),
      result7h30Custom: getTimeSuggest(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 7,
          minuteSleep: 30),
      period7h30Custom: getPeriod(
          time: timeCustom,
          fallInSleep: timeFallInSleep,
          hourSleep: 7,
          minuteSleep: 30),
    );
  }
}
