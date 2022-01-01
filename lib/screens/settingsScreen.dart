import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/dropDownSelector.dart';
import 'package:pomodoro/widgets/settingSlider.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  _settingsScreenState createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  final TextStyle _textStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Color(0xFFE5E5E5));

  double focusTime = 25;
  double shortBreak = 5;
  double longBreak = 15;
  double sections = 4;

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
                settingSlider(
                    label: "Focus time",
                    value: focusTime,
                    onChange: (value) {
                      setState(() {
                        focusTime = value;
                      });
                    }),
                settingSlider(
                    label: "Short break",
                    value: shortBreak,
                    onChange: (value) {
                      setState(() {
                        shortBreak = value;
                      });
                    }),
                settingSlider(
                    label: "Long break",
                    value: longBreak,
                    onChange: (value) {
                      setState(() {
                        longBreak = value;
                      });
                    }),
                settingSlider(
                    label: "Sections",
                    units: "intervals",
                    value: sections,
                    max: 12,
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
