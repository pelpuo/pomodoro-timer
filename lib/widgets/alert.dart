import 'package:flutter/material.dart';

class alert {
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
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
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
