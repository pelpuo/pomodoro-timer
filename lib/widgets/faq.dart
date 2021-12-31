import 'package:flutter/material.dart';

class faq extends StatelessWidget {
  final String heading;
  final String body;

  const faq({required this.heading, required this.body});

  final TextStyle _headingStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Color(0xFF91C2E3));

  final TextStyle _textStyle = const TextStyle(
      fontFamily: "Rupert",
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xFF91C2E3));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              heading,
              style: _headingStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              body,
              style: _textStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
