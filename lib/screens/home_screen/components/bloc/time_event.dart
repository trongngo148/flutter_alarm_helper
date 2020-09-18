abstract class TimeEvent {
  final DateTime currentTime;
  final int timeFallInSleep;
  final DateTime customTime;
  TimeEvent(this.currentTime, this.timeFallInSleep, this.customTime);
}

class NextTime extends TimeEvent {
  NextTime(DateTime currentTime, int timeFallInSleep, DateTime customTime)
      : super(currentTime, timeFallInSleep, customTime);
}


