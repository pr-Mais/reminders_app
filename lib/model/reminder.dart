import 'package:flutter/material.dart';

class Reminder {
  Color color;
  String content;
  TimeOfDay time;
  Repeat repeat;

  Reminder({
    this.color,
    this.content,
    this.time,
    this.repeat,
  });
}

enum Repeat {
  daily,
  weekly,
  monthly,
}
