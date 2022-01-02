import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/models/timerModel.dart';
import 'package:pomodoro/utilities/notify.dart';
import 'package:pomodoro/utilities/persist_data.dart';

class TimerProvider extends ChangeNotifier {
  TimerModel timerModel =
      new TimerModel(workTime: 25, shortBreak: 5, longBreak: 15, sections: 4);

  bool _timerRunning = false;

  int _totalTime = 0;
  int _curTime = 0;
  int _curTotalTime = 0;

  List<int> _sprints = [];
  List<String> _stateTexts = [];
  int _sprintIndex = 0;

  int _minutes = 0;
  int _seconds = 0;
  double _focusPercentage = 0;
  double _totalPercentage = 0;
  Timer? _timer;

  String _stateText = "Start timer";

  Color _sprintColor = const Color(0xFFDA4834);
  Icon _playStateIcon = const Icon(
    Icons.play_arrow_outlined,
    size: 35,
  );

  // Getters
  bool get timerState => _timerRunning;
  String get stateText => _stateText;
  int get sprintIndex => _sprintIndex;
  double get totalPercentage => _totalPercentage;
  double get focusPercentage => _focusPercentage;
  Color get sprintColor => _sprintColor;
  int get minutes => _minutes;
  int get seconds => _seconds;
  Icon get playStateIcon => _playStateIcon;

  // Setters
  void changeTimerState() {
    _timerRunning = !_timerRunning;
    notifyListeners();
  }

  void changeTimerSettings(
      {required int workTime,
      required int shortBreak,
      required int longBreak,
      required int sections}) {
    timerModel.setTimer(
        workTime: workTime,
        shortBreak: shortBreak,
        longBreak: longBreak,
        sections: sections);

    _timer?.cancel();
    initTimer();
    setPauseVals("Start timer");
    _timerRunning = false;
    _stateText = "Start timer";

    saveTimerSettings();
    notifyListeners();
  }

  void saveTimerSettings() {
    List<String> settings = [
      timerModel.workTime.toString(),
      timerModel.shortBreak.toString(),
      timerModel.longBreak.toString(),
      timerModel.sections.toString()
    ];

    persistVals.setAppVals(settings);

    notifyListeners();
  }

  void loadTimerSettings() {
    List<String> vals = persistVals.getAppVals() ?? ["25", "5", "15", "4"];

    timerModel.workTime = int.parse(vals[0]);
    timerModel.shortBreak = int.parse(vals[1]);
    timerModel.longBreak = int.parse(vals[2]);
    timerModel.sections = int.parse(vals[3]);

    // notifyListeners();
  }

  void initTimer() {
    _totalTime = 0;
    _curTime = 0;
    _curTotalTime = 0;

    _sprints = [];
    _stateTexts = [];
    _sprintIndex = 0;

    for (int i = 0; i < timerModel.sections; i++) {
      _sprints.add(timerModel.workTime);
      _stateTexts.add("Work time");
      _totalTime += timerModel.workTime;
      if (i != timerModel.sections - 1) {
        _sprints.add(timerModel.shortBreak);
        _stateTexts.add("Short break");
        _totalTime += timerModel.shortBreak;
      }
    }
    _sprints.add(timerModel.longBreak);
    _stateTexts.add("Long break");
    _totalTime += timerModel.longBreak;
    _curTotalTime = _totalTime * 60;

    _curTime = _sprints[0] * 60;

    _minutes = (_curTime / 60).floor();
    _seconds = _curTime % 60;
    _focusPercentage = (_curTime / 60) / _sprints[0];
    _totalPercentage = (_curTotalTime / 60) / _totalTime;

    //notifyListeners();
  }

  void timerFlowChange() {
    // Pause to start
    if (!_timerRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        controlTime();
      });

      if (_sprintIndex % 2 == 0 &&
          _sprintIndex != timerModel.sections * 2 - 1) {
        _sprintColor = const Color(0xFF34DADA);
      } else {
        _sprintColor = Color(0xFFDAAC34);
      }

      _stateText = _stateTexts[_sprintIndex];
      _playStateIcon = const Icon(
        Icons.pause_outlined,
        size: 35,
      );
    } else {
      //Start to pause
      _timer?.cancel();
      _sprintColor = const Color(0xFFDA4834);
      _stateText = "Paused";
      _playStateIcon = const Icon(
        Icons.play_arrow_outlined,
        size: 35,
      );
    }

    _timerRunning = !_timerRunning;
    notifyListeners();
  }

  void controlTime() {
    if (_curTime > 0) {
      _curTime--;
      _curTotalTime--;
      setTimerVals();
    } else if (_curTime <= 0 && _sprintIndex < timerModel.sections * 2 - 1) {
      _sprintIndex++;
      _curTime = _sprints[_sprintIndex] * 60;
      _stateText = _stateTexts[_sprintIndex];

      if (_stateTexts[_sprintIndex] == "Work time") {
        _sprintColor = const Color(0xFF34DADA);
      } else {
        _sprintColor = Color(0xFFDAAC34);
      }

      Notify().showNotification(
          message: "$_stateText: ${_sprints[_sprintIndex]} min");
    } else if (_curTime <= 0 && _sprintIndex >= timerModel.sections * 2 - 1) {
      _timer?.cancel();
      Notify().showNotification(message: "All sprints completed");
    }

    notifyListeners();
  }

  void stopTimer() {
    _sprintIndex = 0;
    _curTotalTime = _totalTime * 60;
    _curTime = _sprints[0] * 60;
    _timer?.cancel();
    setTimerVals();
    setPauseVals("Start timer");

    notifyListeners();
  }

  void restartTimer() {
    _curTotalTime -= _curTime;

    _curTime = _sprints[_sprintIndex] * 60;
    _curTotalTime += _sprints[_sprintIndex] * 60;

    _timer?.cancel();
    setTimerVals();
    setPauseVals("Paused");

    notifyListeners();
  }

  void setTimerVals() {
    _minutes = (_curTime / 60).floor();
    _seconds = _curTime % 60;
    _focusPercentage = (_curTime / 60) / _sprints[0];
    _totalPercentage = (_curTotalTime / 60) / _totalTime;

    notifyListeners();
  }

  void setPauseVals(String _stateText) {
    _sprintColor = const Color(0xFFDA4834);
    _stateText = _stateText;
    _timerRunning = !_timerRunning;
    _playStateIcon = const Icon(
      Icons.play_arrow_outlined,
      size: 35,
    );

    notifyListeners();
  }
}
