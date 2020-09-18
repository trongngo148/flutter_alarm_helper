import 'dart:async';

import 'package:analog_clock/models/my_theme_provider.dart';
import 'package:analog_clock/screens/home_screen/components/bloc/time_bloc.dart';
import 'package:analog_clock/screens/home_screen/components/bloc/time_event.dart';
import 'package:analog_clock/screens/home_screen/components/bloc/time_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../config/size_config.dart';
import 'suggest_card.dart';
import 'suggest_card2.dart';

class ListSuggestCard extends StatefulWidget {
  final DateTime timeSleep;
  final int timeFallInSleep;
  final bool updateListSuggest;

  const ListSuggestCard(
      {Key key, this.timeSleep, this.timeFallInSleep, this.updateListSuggest})
      : super(key: key);

  @override
  _ListSuggestCardState createState() => _ListSuggestCardState();
}

class _ListSuggestCardState extends State<ListSuggestCard> {
  DateTime _timeOfDay = DateTime.now();

  int indexCurrentTab = 0;
  bool updateTime = false;
  int tempTimeFallInSleep = -1;
  int tempTimeSleepHour = -1;
  int tempTimeSleepMinute = -1;

  bool checkUpdateList() {
    return widget.timeSleep != null
        ? tempTimeFallInSleep == -1 ||
                tempTimeFallInSleep != widget.timeFallInSleep ||
                tempTimeSleepHour != widget.timeSleep.hour ||
                tempTimeSleepMinute != widget.timeSleep.minute
            ? true
            : false
        : tempTimeFallInSleep == -1 ||
                tempTimeFallInSleep != widget.timeFallInSleep
            ? true
            : false;
  }

  void setTempCheck() {
    if (widget.timeSleep != null) {
      tempTimeFallInSleep = widget.timeFallInSleep;
      tempTimeSleepHour = widget.timeSleep.hour;
      tempTimeSleepMinute = widget.timeSleep.minute;
    } else {
      tempTimeFallInSleep = widget.timeFallInSleep;
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (checkUpdateList()) {
        BlocProvider.of<TimeBloc>(context).add(
            NextTime(_timeOfDay, widget.timeFallInSleep, widget.timeSleep));
        setTempCheck();
      }
      if (_timeOfDay.minute != TimeOfDay.now().minute) {
        setState(() {
          _timeOfDay = DateTime.now();
        });
        BlocProvider.of<TimeBloc>(context).add(
            NextTime(_timeOfDay, widget.timeFallInSleep, widget.timeSleep));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      BlocBuilder<TimeBloc, TimeState>(
        builder: (context, TimeState state) {
          return Row(
            children: [
              SuggestCard2(
                suggestHourSleep: 3,
                hourAlarm: "${state.result3h}",
                period: "${state.period3h}",
              ),
              SuggestCard2(
                suggestHourSleep: 4.5,
                hourAlarm: "${state.result4h30}",
                period: "${state.period4h30}",
              ),
              SuggestCard2(
                suggestHourSleep: 6,
                hourAlarm: "${state.result6h}",
                period: "${state.period6h}",
              ),
              SuggestCard2(
                suggestHourSleep: 7.5,
                hourAlarm: "${state.result7h30}",
                period: "${state.period7h30}",
              ),
            ],
          );
        },
      ),
      widget.timeSleep == null
          ? Row(
              children: [
                SuggestCard(
                  suggestHourSleep: 0,
                  hourAlarm: "Trống",
                  period: "",
                ),
                SizedBox(
                  width: getProportionateScreenWidth(25),
                )
              ],
            )
          : BlocBuilder<TimeBloc, TimeState>(
              builder: (context, TimeState state) {
                return Row(
                  children: [
                    SuggestCard2(
                      suggestHourSleep: 3,
                      hourAlarm: "${state.result3hCustom}",
                      period: "${state.period3hCustom}",
                    ),
                    SuggestCard2(
                      suggestHourSleep: 4.5,
                      hourAlarm: "${state.result4h30Custom}",
                      period: "${state.period4h30Custom}",
                    ),
                    SuggestCard2(
                      suggestHourSleep: 6,
                      hourAlarm: "${state.result6hCustom}",
                      period: "${state.period6hCustom}",
                    ),
                    SuggestCard2(
                      suggestHourSleep: 7.5,
                      hourAlarm: "${state.result7h30Custom}",
                      period: "${state.period7h30Custom}",
                    ),
                  ],
                );
              },
            ),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Consumer<MyThemeModel>(
            builder: (context, value, child) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexCurrentTab = 0;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Hiện tại",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              color: indexCurrentTab == 0
                                  ? Theme.of(context).textTheme.headline1.color
                                  : !value.isListenTheme
                                      ? Colors.white60
                                      : Colors.black54,
                              fontSize: getProportionateScreenHeight(3),
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(2),
                      ),
                      Container(
                        height: getProportionateScreenHeight(5),
                        width: getProportionateScreenWidth(1),
                        decoration: BoxDecoration(
                            color: indexCurrentTab == 0
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexCurrentTab = 1;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text("Custom",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    color: indexCurrentTab == 1
                                        ? Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .color
                                        : !value.isListenTheme
                                            ? Colors.white60
                                            : Colors.black54,
                                    fontSize: getProportionateScreenHeight(3),
                                    fontWeight: FontWeight.w300)),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(2),
                      ),
                      Container(
                        height: getProportionateScreenHeight(5),
                        width: getProportionateScreenWidth(1),
                        decoration: BoxDecoration(
                            color: indexCurrentTab == 1
                                ? Colors.blue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          tabs[indexCurrentTab],
        ],
      ),
    );
  }
}
