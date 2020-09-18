import 'dart:async';

import 'package:analog_clock/config/constants.dart';
import 'package:analog_clock/config/size_config.dart';
import 'package:analog_clock/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    bool checkOnce = true;
    super.initState();

    Timer.periodic(Duration(milliseconds: 3000), (_) {
      if (checkOnce) {
        Navigator.push(context,
            PageTransition(child: HomeScreen(), type: PageTransitionType.fade));
        setState(() {
          checkOnce = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: SpinKitPumpingHeart(
            color: kColorStartScreen,
            size: getProportionateScreenWidth(18),
          ),
        ),
      ),
    );
  }
}
