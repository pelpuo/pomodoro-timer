import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/widgets/progress_icons.dart';
import 'package:pomodoro/widgets/alert.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class timerScreen extends StatefulWidget {
  const timerScreen({Key? key}) : super(key: key);

  @override
  _timerScreenState createState() => _timerScreenState();
}

class _timerScreenState extends State<timerScreen> {
  var f = NumberFormat("00");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    TimerProvider myTimer = Provider.of<TimerProvider>(context, listen: false);
    myTimer.initTimer();
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
      body: Consumer<TimerProvider>(
        builder: (context, timer, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              timer.stateText,
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
                      "${((timer.sprintIndex + 1) / 2).round()}/${timer.timerModel.sections}",
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
                        percent: timer.totalPercentage,
                        backgroundColor: const Color(0xFF1A5074),
                        progressColor: const Color(0xFF20788C),
                        circularStrokeCap: CircularStrokeCap.round,
                        center: CircularPercentIndicator(
                          radius: 250,
                          lineWidth: 9,
                          percent: timer.focusPercentage,
                          backgroundColor: const Color(0xFF1A5074),
                          progressColor: timer.sprintColor,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            "${f.format(timer.minutes)}:${f.format(timer.seconds)}",
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
                        total: timer.timerModel.sections,
                        done: ((timer.sprintIndex + 1) / 2).round())
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
                    onPressed: () => alert().showAlert(context, "Restart",
                        "Restart section", timer.restartTimer),
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
                    onPressed: timer.timerFlowChange,
                    color: const Color(0xFF1A5074),
                    textColor: const Color(0xFF34DADA),
                    child: timer.playStateIcon,
                    padding: const EdgeInsets.all(10),
                    shape: const CircleBorder(),
                  ),
                  MaterialButton(
                    elevation: 0,
                    onPressed: () => alert().showAlert(
                        context, "Stop", "Stop timer", timer.stopTimer),
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
      ),
    );
  }
}
