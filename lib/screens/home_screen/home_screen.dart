import 'dart:async';
import 'dart:io';

import 'package:analog_clock/config/constants.dart';
import 'package:analog_clock/models/data_clock.dart';
import 'package:analog_clock/screens/home_screen/components/bloc/time_event.dart';
import 'package:analog_clock/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_span/time_span.dart';

import '../../config/size_config.dart';
import '../../config/size_config.dart';
import 'components/bloc/time_bloc.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int group = 1;
  bool isCollapsed = false;
  double screenHeight, screenWidth;
  bool isDropDownOpened = false;
  OverlayEntry floatingDropDown;
  int timeFallInSleep = 0;
  DateTime timeSleep;
  int timeSleepHour = 0;
  int timeSleepMinute = 0;
  List<DataClock> data;
  int firstInput;
  DateTime currentTimePress;
  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 20,
          width: getProportionateScreenWidth(90),
          top: AppBar().preferredSize.height * 1.5,
          child: buildCustomDropBox(context),
        );
      },
    );
  }

  void changeFirstInput() {
    DataClock data2 = new DataClock(
        id: 0,
        timeFallInSleep: data[0].timeFallInSleep,
        timeSleepHour: 0,
        timeSleepMinute: 0,
        firstInput: 0);
    DBProvider.db.updateData(data2);
  }

  void getData() async {
    data = await DBProvider.db.getData();

    setState(() {
      timeFallInSleep = data[0].timeFallInSleep;
      firstInput = data[0].firstInput;
      firstInput != 1
          ? timeSleep = new DateTime(
              2020, 12, 12, data[0].timeSleepHour, data[0].timeSleepMinute, 0)
          : timeSleep = null;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Material buildCustomDropBox(BuildContext context) {
    return Material(
      child: Container(
        height: getProportionateScreenHeight(28),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 0.5),
              blurRadius: 5,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thời gian đi ngủ:",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: getProportionateScreenWidth(4.5),
                        fontWeight: FontWeight.w400),
                  ),
                  RaisedButton(
                    onPressed: () {
                      DatePicker.showTimePicker(
                        context,
                        showTitleActions: true,
                        showHourColumn: true,
                        showSecondsColumn: false,
                        onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        },
                        onConfirm: (date) {
                          print('Confirm $date');
                          setState(() {
                            timeSleep = date;
                            DataClock dataClock = DataClock(
                                id: 0,
                                timeFallInSleep: timeFallInSleep,
                                timeSleepHour: date.hour,
                                timeSleepMinute: date.minute,
                                firstInput: 0);
                            DBProvider.db.updateData(dataClock);

                            getData();
                          });
                        },
                      );
                    },
                    child: timeSleep == null
                        ? Text('Trống')
                        : Text('${timeSleep.hour}:${timeSleep.minute}'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thời gian đi vào giấc ngủ:",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: getProportionateScreenWidth(4.5),
                        fontWeight: FontWeight.w400),
                  ),
                  RaisedButton(
                    onPressed: () {
                      DatePicker.showTimePicker(
                        context,
                        showTitleActions: true,
                        showHourColumn: false,
                        showSecondsColumn: false,
                        onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        },
                        onConfirm: (date) {
                          print('Confirm $date');
                          setState(() {
                            if (timeSleep != null) {
                              DataClock dataClock = DataClock(
                                id: 0,
                                timeFallInSleep: date.minute,
                                timeSleepHour: timeSleep.hour,
                                timeSleepMinute: timeSleep.minute,
                                firstInput: 0,
                              );
                              DBProvider.db.updateData(dataClock);
                            } else {
                              DataClock dataClock = DataClock(
                                id: 0,
                                timeFallInSleep: date.minute,
                                timeSleepHour: 0,
                                timeSleepMinute: 0,
                                firstInput: 1,
                              );
                              DBProvider.db.updateData(dataClock);
                            }
                            getData();
                          });
                        },
                      );
                    },
                    child: timeFallInSleep == 0
                        ? Text('Trống')
                        : Text('$timeFallInSleep phút'),
                  ),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  floatingDropDown.remove();
                  setState(() {
                    isDropDownOpened = !isDropDownOpened;
                  });
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: Text(
                            kTextCSKH,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(5),
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .color),
                          ),
                        ),
                        actions: [
                          FlatButton(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Đóng",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .color,
                                    fontSize: getProportionateScreenWidth(5)),
                              ))
                        ],
                      );
                    },
                  );
                },
                child: Text("Cơ Sở Khoa Học"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: buildAppBar(context),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Body(
          timeFallInSleep: timeFallInSleep,
          timeSleep: timeSleep,
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentTimePress == null ||
        now.difference(currentTimePress) > Duration(seconds: 2)) {
      currentTimePress = now;
      Fluttertoast.showToast(msg: exit_message);
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/Settings.svg",
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            setState(() {
              if (isDropDownOpened) {
                floatingDropDown.remove();
              } else {
                floatingDropDown = _createFloatingDropdown();
                Overlay.of(context).insert(floatingDropDown);
              }
              isDropDownOpened = !isDropDownOpened;
            });
          }),
    );
  }
}
