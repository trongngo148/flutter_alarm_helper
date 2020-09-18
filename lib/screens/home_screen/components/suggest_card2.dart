import 'package:analog_clock/screens/home_screen/components/bloc/time_bloc.dart';
import 'package:flutter/material.dart';

import '../../../config/size_config.dart';

class SuggestCard2 extends StatefulWidget {
  final double suggestHourSleep;
  final String hourAlarm;
  final String period;
  final String temp;
  const SuggestCard2({
    Key key,
    @required this.suggestHourSleep,
    @required this.hourAlarm,
    @required this.period,
    this.temp,
  }) : super(key: key);

  @override
  _SuggestCard2State createState() => _SuggestCard2State();
}

class _SuggestCard2State extends State<SuggestCard2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: getProportionateScreenWidth(67),
        child: AspectRatio(
          aspectRatio: 1.32,
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(5)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).primaryIconTheme.color)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.suggestHourSleep != 0
                      ? "+ ${widget.suggestHourSleep} Giờ Ngủ"
                      : "",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: getProportionateScreenWidth(5)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.suggestHourSleep != 0
                    ? "Bạn nên thức dậy vào lúc: "
                    : ""),
                SizedBox(
                  height: getProportionateScreenHeight(3),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.hourAlarm,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: getProportionateScreenHeight(9)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        widget.period,
                        style:
                            TextStyle(fontSize: getProportionateScreenWidth(5)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
