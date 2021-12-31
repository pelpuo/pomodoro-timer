import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/widgets/progress_icons.dart';

class timerScreen extends StatefulWidget {
  const timerScreen({Key? key}) : super(key: key);

  @override
  _timerScreenState createState() => _timerScreenState();
}

class _timerScreenState extends State<timerScreen> {
  String stateText = "Work time";
  String remainingTime = "18:59";
  int currentSection = 3;
  int totalSections = 8;

  bool timerRunning = false;
  Color sprintColor = const Color(0xFFDA4834);
  Icon playStateIcon = const Icon(
    Icons.play_arrow_outlined,
    size: 35,
  );

  void timerFlowChange() {
    setState(() {
      if (!timerRunning) {
        sprintColor = const Color(0xFF34DADA);
        stateText = "Work time";
        playStateIcon = const Icon(
          Icons.pause_outlined,
          size: 35,
        );
      } else {
        sprintColor = const Color(0xFFDA4834);
        stateText = "Paused";
        playStateIcon = const Icon(
          Icons.play_arrow_outlined,
          size: 35,
        );
      }

      timerRunning = !timerRunning;
    });
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
                    "$currentSection/$totalSections",
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
                      percent: 0.9,
                      backgroundColor: const Color(0xFF1A5074),
                      progressColor: const Color(0xFF20788C),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: CircularPercentIndicator(
                        radius: 250,
                        lineWidth: 9,
                        percent: 0.7,
                        backgroundColor: const Color(0xFF1A5074),
                        progressColor: sprintColor,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: const Text(
                          "18:59",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Rupert",
                              fontWeight: FontWeight.w500,
                              fontSize: 72,
                              color: Color(0xFFefefef)),
                        ),
                      ),
                    ),
                  ),
                  const progressIcons(total: 8, done: 3)
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
                  onPressed: () {},
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
                  onPressed: () {},
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
}
