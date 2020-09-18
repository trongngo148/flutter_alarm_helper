import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;
  ClockPainter(this.context, this.dateTime);
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);

//Minute Calculation
    double minX =
        centerX + size.width * 0.37 * cos((dateTime.minute * 6) * pi / 180);
    double minY =
        centerY + size.width * 0.37 * sin((dateTime.minute * 6) * pi / 180);
//Minute Line
    canvas.drawLine(
        center,
        Offset(minX, minY),
        Paint()
          ..color = Theme.of(context).accentColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);
//Hour Calculation
//dateTime.hour * 30 because 360/12 = 30
//dateTime.minute * 0.5 because each minute we want to turn hour line a little
    double hourX = centerX +
        size.width *
            0.27 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY +
        size.width *
            0.27 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
//Hour Line
    canvas.drawLine(
        center,
        Offset(hourX, hourY),
        Paint()
          ..color = Theme.of(context).colorScheme.secondary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);
//Second Calculation
//size.width * 0.4 define our line height
//dateTime.second * 6 because 360 / 60 = 60
    double secondX =
        centerX + size.width * 0.4 * cos((dateTime.second * 6) * pi / 180);
    double secondY =
        centerY + size.width * 0.4 * sin((dateTime.second * 6) * pi / 180);
//Second Line
    canvas.drawLine(center, Offset(secondX, secondY),
        Paint()..color = Theme.of(context).primaryColor);

//Center dots
    Paint dotPainter = Paint()
      ..color = Theme.of(context).primaryIconTheme.color;
    canvas.drawCircle(center, 24, dotPainter);
    canvas.drawCircle(
        center, 23, Paint()..color = Theme.of(context).backgroundColor);
    canvas.drawCircle(center, 10, dotPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
