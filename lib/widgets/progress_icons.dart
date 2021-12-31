import 'package:flutter/material.dart';

class progressIcons extends StatelessWidget {
  final int total;
  final int done;

  const progressIcons({required this.total, required this.done});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 8.0;

    final completed = Container(
      width: iconSize,
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: iconSize,
      decoration: BoxDecoration(
        color: Color(0xFF34DADA),
        shape: BoxShape.circle,
      ),
    );

    final notCompleted = Container(
      width: iconSize,
      margin: const EdgeInsets.only(left: 3, right: 3),
      height: iconSize,
      decoration: BoxDecoration(
        color: Color(0xFF1A5074),
        shape: BoxShape.circle,
      ),
    );

    List<Container> icons = [];

    for (int i = 0; i < total; i++) {
      if (i < done) {
        icons.add(completed);
      } else {
        icons.add(notCompleted);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: icons,
      ),
    );
  }
}
