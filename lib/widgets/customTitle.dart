import 'package:flutter/material.dart';

import '../usefull/constants.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final double bottom, top;
  final Color color;
  CustomTitle(this.text,
      {super.key,
      required this.bottom,
      required this.top,
      this.color = strokeTextColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'OpenSans',
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
