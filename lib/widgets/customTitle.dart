import 'package:flutter/material.dart';

import '../usefull/constants.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final double bottom, top;

  CustomTitle(this.text, {super.key, required this.bottom, required this.top});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'OpenSans',
          color: strokeTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }
}
