import 'dart:async';

import 'package:flutter/material.dart';

class TimerModel {
  int workTime;
  int shortBreak;
  int longBreak;
  int sections;

  TimerModel(
      {required this.workTime,
      required this.shortBreak,
      required this.longBreak,
      required this.sections});

  int get getWorkTime => workTime;
  int get getShortBreak => shortBreak;
  int get getLongBreak => longBreak;
  int get getSections => sections;

  void setTimer(
      {required int workTime,
      required int shortBreak,
      required int longBreak,
      required int sections}) {
    this.workTime = workTime;
    this.shortBreak = shortBreak;
    this.longBreak = longBreak;
    this.sections = sections;
  }
}
