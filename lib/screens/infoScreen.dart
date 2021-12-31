import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/faq.dart';

class infoScreen extends StatefulWidget {
  const infoScreen({Key? key}) : super(key: key);

  @override
  _infoScreenState createState() => _infoScreenState();
}

class _infoScreenState extends State<infoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF0C2C41),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Info",
            style: TextStyle(
                fontFamily: "Rupert",
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF0C2C41),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                faq(
                    heading: "Lorem Ipsum?",
                    body:
                        "The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. It uses a timer to break work into intervals, traditionally 25 minutes in length, separated by short breaks. Each interval is known as a pomodoro, from the Italian word for tomato, after the tomato-shaped kitchen timer Cirillo used as a university student. The technique has been widely popularized by apps and websites providing timers and instructions. Closely related to concepts such as timeboxing and iterative and incremental development used in software design, the method has been adopted in pair programming contexts."),
                faq(
                    heading: "Lorem Ipsum?",
                    body:
                        "The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. It uses a timer to break work into intervals, traditionally 25 minutes in length, separated by short breaks. Each interval is known as a pomodoro, from the Italian word for tomato, after the tomato-shaped kitchen timer Cirillo used as a university student. The technique has been widely popularized by apps and websites providing timers and instructions. Closely related to concepts such as timeboxing and iterative and incremental development used in software design, the method has been adopted in pair programming contexts."),
                faq(
                    heading: "Lorem Ipsum?",
                    body:
                        "The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. It uses a timer to break work into intervals, traditionally 25 minutes in length, separated by short breaks. Each interval is known as a pomodoro, from the Italian word for tomato, after the tomato-shaped kitchen timer Cirillo used as a university student. The technique has been widely popularized by apps and websites providing timers and instructions. Closely related to concepts such as timeboxing and iterative and incremental development used in software design, the method has been adopted in pair programming contexts."),
                faq(
                    heading: "Lorem Ipsum?",
                    body:
                        "The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. It uses a timer to break work into intervals, traditionally 25 minutes in length, separated by short breaks. Each interval is known as a pomodoro, from the Italian word for tomato, after the tomato-shaped kitchen timer Cirillo used as a university student. The technique has been widely popularized by apps and websites providing timers and instructions. Closely related to concepts such as timeboxing and iterative and incremental development used in software design, the method has been adopted in pair programming contexts.")
              ],
            ),
          ),
        ));
  }
}
