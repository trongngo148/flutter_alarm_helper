import 'dart:async';

import 'package:analog_clock/config/size_config.dart';
import 'package:analog_clock/models/data_clock.dart';
import 'package:analog_clock/screens/home_screen/home_screen.dart';
import 'package:analog_clock/screens/start_screen/start_screen.dart';
import 'package:analog_clock/utils/database.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTime;
  SharedPreferences _prefs;
  @override
  void initState() {
    super.initState();
    // bool isFirstTime;
    _isFistTime().then((value) {
      isFirstTime = value;
    });
    Timer(Duration(seconds: 2), () {
      //_setPassPage();
      Navigator.push(
          context,
          PageTransition(
            child: isFirstTime ? StartScreen() : HomeScreen(),
            //child: StartScreen(),
            type: PageTransitionType.fade,
          ));
    });
  }

  Future<bool> _isFistTime() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool _isFirstTime = _prefs.getBool('first_time');
    if (_isFirstTime != null && !_isFirstTime) {
      return false;
    } else {
      print('first time');
      DataClock _data = DataClock(
          id: 0,
          timeFallInSleep: 0,
          timeSleepHour: 0,
          timeSleepMinute: 0,
          firstInput: 1);
      DBProvider.db.newData(_data);
      _prefs.setBool('first_time', false);
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Material(
      // child: Transform.scale(
      //   scale: getProportionateScreenWidth(0.8),
      //   child: AnimatedSplashScreen(
      //     splash: Image.asset(
      //       "assets/images/logo_transparent.png",
      //     ),
      //     nextScreen: isFirstTime ?? isFirstTime ? StartScreen() : HomeScreen(),
      //     splashTransition: SplashTransition.decoratedBoxTransition,
      //     duration: 2500,
      //   ),
      child: Image.asset(
        "assets/images/logo_transparent.png",
        scale: getProportionateScreenWidth(1.5),
      ),
    );
  }
}
