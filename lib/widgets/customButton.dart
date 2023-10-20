import 'package:flutter/material.dart';

import '../usefull/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onCLick;
  CustomButton({super.key, required this.onCLick, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onCLick,
          style: ElevatedButton.styleFrom(
              backgroundColor: widgetsColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ));
  }
}
