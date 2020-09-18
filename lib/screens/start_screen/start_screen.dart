import 'dart:async';
import 'dart:io';

import 'package:analog_clock/config/constants.dart';
import 'package:analog_clock/models/data_clock.dart';
import 'package:analog_clock/config/size_config.dart';
import 'package:analog_clock/screens/loading/loading_screen.dart';
import 'package:analog_clock/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'start_details.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _loading = false;
  DateTime currentBackPressTime;
  PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> listDetails = [
    {
      "text": "",
      "image": "assets/images/1_guide.jpg",
    },
    {
      "text": "",
      "image": "assets/images/2_guide.jpg",
    },
    {
      "text": "",
      "image": "assets/images/3_guide.jpg",
    },
    {
      "text": "Cơ sở khoa học:",
      "image": "assets/images/splash_test_3.png",
    },
    {
      "text": "Thời gian bạn đi vào giấc ngủ:",
      "image": "",
    },
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return _loading
        ? LoadingScreen()
        : Material(
            child: SafeArea(
              child: WillPopScope(
                onWillPop: onWillPop,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: getProportionateScreenHeight(8)),
                          child: Text(
                            "HƯỚNG DẪN",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(8)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: PageView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listDetails.length,
                          controller: _pageController,
                          itemBuilder: (context, index) => StartDetails(
                            image: listDetails[index]['image'],
                            text: listDetails[index]['text'],
                            indexCurrent: index,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(listDetails.length,
                                    (index) => buildDot(index)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(6)),
                                child: InkWell(
                                  onTap: _currentPage < listDetails.length - 1
                                      ? () {
                                          setState(() {
                                            _currentPage++;
                                          });
                                          _pageController.animateToPage(
                                              _currentPage,
                                              duration: kAnimationDuration,
                                              curve: Curves.easeInCirc);
                                        }
                                      : () async {
                                          List<DataClock> data =
                                              await DBProvider.db.getData();
                                          print(data[0].timeFallInSleep);

                                          data[0].timeFallInSleep != 0
                                              // ? Navigator.push(
                                              //     context,
                                              //     PageTransition(
                                              //         child: HomeScreen(),
                                              //         type: PageTransitionType
                                              //             .fade))
                                              ? buildNavigator()
                                              : buildShowDialog(context);
                                        },
                                  child: Container(
                                    height: getProportionateScreenHeight(8),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kColorStartScreen,
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Continue",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              getProportionateScreenWidth(6)),
                                    )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void buildNavigator() {
    setState(() {
      _loading = true;
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: exit_message);
      return Future.value(false);
    }
    exit(0);
    return Future.value(true);
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cảnh Báo!!"),
          content: Text("Bạn chưa nhập thời gian đi vào giấc ngủ"),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(5),
                      color: Colors.black),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: getProportionateScreenWidth(2)),
      height: getProportionateScreenHeight(1.5),
      width: _currentPage == index
          ? getProportionateScreenWidth(10.5)
          : getProportionateScreenWidth(3),
      decoration: BoxDecoration(
        color: _currentPage == index ? kColorStartScreen : Colors.grey[350],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
