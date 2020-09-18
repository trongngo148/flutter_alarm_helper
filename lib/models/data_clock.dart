import 'dart:convert';

class DataClock {
  final int id;
  final int timeFallInSleep;
  final int timeSleepHour;
  final int timeSleepMinute;
  final int firstInput;

  DataClock({
    this.id,
    this.timeFallInSleep,
    this.timeSleepHour,
    this.timeSleepMinute,
    this.firstInput,
  });

  factory DataClock.fromJson(Map<String, dynamic> json) => DataClock(
        id: json["id"],
        timeFallInSleep: json["timeFallInSleep"],
        timeSleepHour: json["timeSleepHour"],
        timeSleepMinute: json["timeSleepMinute"],
        firstInput: json["firstInput"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timeFallInSleep": timeFallInSleep,
        "timeSleepHour": timeSleepHour,
        "timeSleepMinute": timeSleepMinute,
        "firstInput": firstInput,
      };
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "timeFallInSleep": timeFallInSleep,
      "timeSleepHour": timeSleepHour,
      "timeSleepMinute": timeSleepMinute,
      "firstInput": firstInput,
    };
  }
}

DataClock dataFormJson(String str) => DataClock.fromJson(json.decode(str));
String dataToJson(DataClock data) => json.encode(data.toJson());
