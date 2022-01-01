import 'package:flutter/material.dart';

class settingSlider extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final Function onChange;
  final String units;

  final TextStyle _textStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Color(0xFF91C2E3));

  final TextStyle _valueStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w300,
      fontSize: 18,
      color: Color(0xFF91C2E3));

  const settingSlider(
      {Key? key,
      required this.label,
      required this.value,
      this.min = 1,
      this.max = 60,
      this.units = "min",
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: _textStyle,
                ),
                Text(
                  "${value.floor().toString()} $units",
                  style: _valueStyle,
                )
              ],
            ),
          ),
          Slider(
            activeColor: Color(0xFF2399A5),
            value: this.value.floorToDouble(),
            onChanged: (value) {
              onChange(value);
            },
            min: this.min,
            divisions: this.max.round(),
            max: this.max,
          )
        ],
      ),
    );
  }
}
