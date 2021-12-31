import 'package:flutter/material.dart';

class dropDownSelector extends StatelessWidget {
  final List<String> itemList;
  final String? target;
  final Function onChange;
  final String label;
  const dropDownSelector(
      {required this.label,
      required this.itemList,
      required this.target,
      required this.onChange});

  final TextStyle _textStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Color(0xFF91C2E3));

  final TextStyle _listItemStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w300,
      fontSize: 18,
      color: Color(0xFF91C2E3));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32), color: Color(0xFF1A5074)),
      padding: const EdgeInsets.only(top: 4, right: 24, bottom: 4, left: 24),
      margin: const EdgeInsets.only(top: 3, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.label,
            style: _textStyle,
          ),
          Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: const Color(0xFF1A5074)),
            child: DropdownButton(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF91C2E3),
              ),
              value: target,
              items: itemList
                  .map((period) => DropdownMenuItem(
                        child: Text(
                          period,
                          style: _listItemStyle,
                        ),
                        value: period,
                      ))
                  .toList(),
              onChanged: (value) {
                onChange(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
