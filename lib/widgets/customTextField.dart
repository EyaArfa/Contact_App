import 'package:callapp/usefull/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? icon;
  final TextInputType? keyboardType;
  final bool show;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextField(this.hintText,
      {super.key,
      this.controller,
      this.icon,
      this.keyboardType,
      this.show = false,
      this.validator});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: errorColor)),
            errorStyle: const TextStyle(color: errorColor),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: widgetsColor,
              ),
            ),
            prefixIcon: icon,
            prefixIconColor: widgetsColor),
        obscureText: show,
      ),
    );
  }
}
