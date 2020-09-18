import 'package:flutter/material.dart';

import '../../../config/size_config.dart';

class SuggestCard extends StatelessWidget {
  final double suggestHourSleep;
  final String hourAlarm;
  final String period;
  const SuggestCard({
    Key key,
    @required this.suggestHourSleep,
    @required this.hourAlarm,
    @required this.period,
  }) : super(key: key);

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
                  suggestHourSleep != 0 ? "+ ${suggestHourSleep} Giờ Ngủ" : "",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: getProportionateScreenWidth(5)),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(suggestHourSleep != 0 ? "Bạn nên thức dậy vào lúc: " : ""),
                SizedBox(
                  height: getProportionateScreenHeight(3),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      hourAlarm,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontSize: getProportionateScreenHeight(15)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        period,
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
