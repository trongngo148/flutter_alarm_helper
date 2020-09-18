import 'package:analog_clock/config/constants.dart';
import 'package:analog_clock/models/data_clock.dart';
import 'package:analog_clock/screens/start_screen/start_screen.dart';
import 'package:analog_clock/utils/database.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class StartDetails extends StatefulWidget {
  final String text;
  final String image;
  final int indexCurrent;
  const StartDetails({Key key, this.text, this.image, this.indexCurrent})
      : super(key: key);

  @override
  _StartDetailsState createState() => _StartDetailsState();
}

class _StartDetailsState extends State<StartDetails> {
  int minuteFallInSleep = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(5),
                    color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(3),
        ),
        widget.indexCurrent == 3
            ? Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10)),
                    child: Text(
                      kTextCSKH,
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(5),
                          color: Colors.blueGrey[600]),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              )
            : widget.image != ''
                ? Image.asset(
                    widget.image,
                    height: getProportionateScreenHeight(40),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(10)),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: getProportionateScreenWidth(15),
                          right: getProportionateScreenWidth(15)),
                      child: TextField(
                        style:
                            TextStyle(fontSize: getProportionateScreenWidth(7)),
                        onChanged: (value) {
                          DataClock _data = DataClock(
                              id: 0,
                              timeFallInSleep: int.parse(value),
                              timeSleepHour: 0,
                              timeSleepMinute: 0,
                              firstInput: 1);
                          print(_data.toString());
                          DBProvider.db.updateData(_data);
                        },
                        decoration:
                            new InputDecoration(labelText: 'Nhập số phút'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
      ],
    );
  }
}
