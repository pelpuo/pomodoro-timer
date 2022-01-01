import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/widgets/progress_icons.dart';
import 'package:intl/intl.dart';

class timerScreen extends StatefulWidget {
  const timerScreen({Key? key}) : super(key: key);

  @override
  _timerScreenState createState() => _timerScreenState();
}

class _timerScreenState extends State<timerScreen> {
  String stateText = "Start timer";

  var f = NumberFormat("00");

  Color sprintColor = const Color(0xFFDA4834);
  Icon playStateIcon = const Icon(
    Icons.play_arrow_outlined,
    size: 35,
  );

  int workTime = 1;
  int shortBreak = 1;
  int longBreak = 1;
  int sections = 4;
  bool timerRunning = false;

  int totalTime = 0;
  int curTime = 0;
  int curTotalTime = 0;
  int minutes = 0;
  int seconds = 0;
  double focusPercentage = 1;
  double totalPercentage = 1;
  Timer? timer;

  List<int> sprints = [];
  List<String> stateTexts = [];
  int sprintIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      for (int i = 0; i < sections; i++) {
        sprints.add(workTime);
        stateTexts.add("Work time");
        totalTime += workTime;
        if (i != sections - 1) {
          sprints.add(shortBreak);
          stateTexts.add("Short break");
          totalTime += shortBreak;
        }
      }
      sprints.add(longBreak);
      stateTexts.add("Long break");
      totalTime += longBreak;
      curTotalTime = totalTime * 60;

      curTime = sprints[0] * 60;

      minutes = (curTime / 60).floor();
      seconds = curTime % 60;
      focusPercentage = (curTime / 60) / sprints[0];
      totalPercentage = (curTotalTime / 60) / totalTime;
    });
  }

  void timerFlowChange() {
    // Pause to start
    if (!timerRunning) {
      timer = Timer.periodic(Duration(seconds: 1), (_) {
        controlTime();
      });

      setState(() {
        if (sprintIndex % 2 == 0 && sprintIndex != sections * 2 - 1) {
          sprintColor = const Color(0xFF34DADA);
        } else {
          sprintColor = Color(0xFFDAAC34);
        }

        stateText = stateTexts[sprintIndex];
        playStateIcon = const Icon(
          Icons.pause_outlined,
          size: 35,
        );
      });
    } else {
      //Start to pause
      timer?.cancel();
      setState(() {
        sprintColor = const Color(0xFFDA4834);
        stateText = "Paused";
        playStateIcon = const Icon(
          Icons.play_arrow_outlined,
          size: 35,
        );
      });
    }

    setState(() {
      timerRunning = !timerRunning;
    });
  }

  void controlTime() {
    if (curTime > 0) {
      setState(() {
        curTime--;
        curTotalTime--;
        setTimerVals();
      });
    } else if (curTime <= 0 && sprintIndex < sections * 2 - 1) {
      setState(() {
        sprintIndex++;
        curTime = sprints[sprintIndex] * 60;
        stateText = stateTexts[sprintIndex];

        if (stateTexts[sprintIndex] == "Work time") {
          sprintColor = const Color(0xFF34DADA);
        } else {
          sprintColor = Color(0xFFDAAC34);
        }
      });
    } else if (curTime <= 0 && sprintIndex >= sections * 2 - 1) {
      timer?.cancel();
    }
  }

  void stopTimer() {
    setState(() {
      sprintIndex = 0;
      curTotalTime = totalTime * 60;
      curTime = sprints[0] * 60;
      timer?.cancel();
      setTimerVals();
      setPauseVals("Start timer");
    });
    Navigator.of(context).pop();
  }

  void restartTimer() {
    setState(() {
      curTotalTime -= curTime;

      curTime = sprints[sprintIndex] * 60;
      curTotalTime += sprints[sprintIndex] * 60;

      timer?.cancel();
      setTimerVals();
      setPauseVals("Paused");
    });

    Navigator.of(context).pop();
  }

  void setTimerVals() {
    minutes = (curTime / 60).floor();
    seconds = curTime % 60;
    focusPercentage = (curTime / 60) / sprints[0];
    totalPercentage = (curTotalTime / 60) / totalTime;
  }

  void setPauseVals(String _stateText) {
    sprintColor = const Color(0xFFDA4834);
    stateText = _stateText;
    timerRunning = !timerRunning;
    playStateIcon = const Icon(
      Icons.play_arrow_outlined,
      size: 35,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C2C41),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pomodoro timer",
          style: TextStyle(
              fontFamily: "Rupert", fontWeight: FontWeight.bold, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF0C2C41),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            stateText,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: "Rupert",
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Color(0xFFE5E5E5)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Column(
                children: [
                  Text(
                    "${((sprintIndex + 1) / 2).round()}/$sections",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Rupert",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF1A5074)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: CircularPercentIndicator(
                      radius: 284.0,
                      lineWidth: 9.0,
                      percent: totalPercentage,
                      backgroundColor: const Color(0xFF1A5074),
                      progressColor: const Color(0xFF20788C),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: CircularPercentIndicator(
                        radius: 250,
                        lineWidth: 9,
                        percent: focusPercentage,
                        backgroundColor: const Color(0xFF1A5074),
                        progressColor: sprintColor,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          "${f.format(minutes)}:${f.format(seconds)}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Rupert",
                              fontWeight: FontWeight.w500,
                              fontSize: 68,
                              color: Color(0xFFefefef)),
                        ),
                      ),
                    ),
                  ),
                  progressIcons(
                      total: sections, done: ((sprintIndex + 1) / 2).round())
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  elevation: 0,
                  onPressed: () => showAlert(
                      context, "Restart", "Restart section", restartTimer),
                  color: const Color(0xFF0C2C41),
                  textColor: const Color(0xFF34DADA),
                  child: const Icon(
                    Icons.refresh,
                    size: 24,
                  ),
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(
                    side: BorderSide(color: Color(0xFF1A5074), width: 3),
                  ),
                ),
                MaterialButton(
                  onPressed: timerFlowChange,
                  color: const Color(0xFF1A5074),
                  textColor: const Color(0xFF34DADA),
                  child: playStateIcon,
                  padding: const EdgeInsets.all(10),
                  shape: const CircleBorder(),
                ),
                MaterialButton(
                  elevation: 0,
                  onPressed: () =>
                      showAlert(context, "Stop", "Stop timer", stopTimer),
                  color: const Color(0xFF0C2C41),
                  textColor: const Color(0xFF34DADA),
                  child: const Icon(
                    Icons.stop,
                    size: 24,
                  ),
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(
                      side: BorderSide(color: Color(0xFF1A5074), width: 3)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextStyle _alertTitle = TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Color(0xFF91C2E3));
  TextStyle _alertBody = TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xFF91C2E3));
  TextStyle _alertPrompt = TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xFF91C2E3));

  void showAlert(BuildContext context, title, content, onConfirm) => showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Color(0xFF1A5074),
            title: Text(
              title,
              style: _alertTitle,
            ),
            content: Text(
              content,
              style: _alertBody,
            ),
            actions: [
              FlatButton(
                  onPressed: onConfirm,
                  child: Text(
                    "Yes",
                    style: _alertPrompt,
                  )),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "No",
                    style: _alertPrompt,
                  )),
            ],
          ));
}
