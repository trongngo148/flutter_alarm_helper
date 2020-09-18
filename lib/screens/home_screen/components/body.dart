import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/time_bloc.dart';
import 'clock.dart';
import 'list_suggest_card.dart';
import 'time_in_hour_and_minute.dart';

class Body extends StatefulWidget {
  final DateTime timeSleep;
  final int timeFallInSleep;

  const Body({Key key, this.timeSleep, this.timeFallInSleep}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text("Developed by TrongDepTrai",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            Expanded(
              flex: 2,
              child: TimeInHourAndMinute(),
            ),
            Expanded(
              flex: 7,
              child: Clock(),
            ),
            Expanded(
              flex: 4,
              //child: buildSingleChildScrollView(tabs),
              child: BlocProvider(
                create: (context) => TimeBloc(),
                child: ListSuggestCard(
                  timeFallInSleep: widget.timeFallInSleep,
                  timeSleep: widget.timeSleep,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
