import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/dropDownSelector.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  _settingsScreenState createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  final List<String> timePeriods = [
    "1 min  ",
    "2 min  ",
    "3 min  ",
    "4 min  ",
    "5 min  ",
    "6 min  ",
    "7 min  ",
    "8 min  ",
    "9 min  ",
    "10 min  ",
    "11 min  ",
    "12 min  ",
    "13 min  ",
    "14 min  ",
    "15 min  ",
    "16 min  ",
    "17 min  ",
    "18 min  ",
    "19 min  ",
    "20 min  "
  ];
  final List<String> sectionPeriods = [
    "1 interval  ",
    "2 intervals  ",
    "3 intervals  "
  ];

  final TextStyle _textStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Color(0xFFE5E5E5));

  String? focusTime;
  String? shortBreak;
  String? longBreak;
  String? sections;

  @override
  Widget build(BuildContext context) {
    // for (int i = 1; i <= 60; i++) {
    //   timePeriods.add(i.toString());
    // }
    // for (int i = 1; i <= 16; i++) {
    //   timePeriods.add(i.toString());
    // }

    return Scaffold(
      backgroundColor: const Color(0xFF0C2C41),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
              fontFamily: "Rupert", fontWeight: FontWeight.bold, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF0C2C41),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                dropDownSelector(
                    label: "Focus time",
                    itemList: timePeriods,
                    target: focusTime,
                    onChange: (value) {
                      setState(() {
                        focusTime = value;
                      });
                    }),
                dropDownSelector(
                    label: "Short break",
                    itemList: timePeriods,
                    target: shortBreak,
                    onChange: (value) {
                      setState(() {
                        shortBreak = value;
                      });
                    }),
                dropDownSelector(
                    label: "Long break",
                    itemList: timePeriods,
                    target: longBreak,
                    onChange: (value) {
                      setState(() {
                        longBreak = value;
                      });
                    }),
                dropDownSelector(
                    label: "Sections",
                    itemList: sectionPeriods,
                    target: sections,
                    onChange: (value) {
                      setState(() {
                        sections = value;
                      });
                    }),
              ],
            )),
            Row(
              children: [
                MaterialButton(
                  elevation: 0,
                  onPressed: () {},
                  color: const Color(0xFF0C2C41),
                  textColor: const Color(0xFF34DADA),
                  child: Text(
                    "Cancel",
                    style: _textStyle,
                  ),
                  padding: const EdgeInsets.only(
                      top: 14, bottom: 14, left: 54, right: 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                MaterialButton(
                  elevation: 0,
                  onPressed: () {},
                  color: const Color(0xFF0C2C41),
                  textColor: const Color(0xFF34DADA),
                  child: Text(
                    "Save",
                    style: _textStyle,
                  ),
                  padding: const EdgeInsets.only(
                      top: 14, bottom: 14, left: 54, right: 54),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side:
                          const BorderSide(color: Color(0xFF34DADA), width: 3)),
                )
              ],
            ),
            const SizedBox(
              height: 14,
            )
          ],
        ),
      ),
    );
  }
}
