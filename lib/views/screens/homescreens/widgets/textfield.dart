import 'package:flutter/material.dart';
import 'package:planetmediamt/utils/constants.dart';

class Formfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  const Formfield(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: textColor),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: textColor)),
        label: Text(
          labelText,
          style: TextStyle(color: textColor),
        ),
        floatingLabelStyle: TextStyle(color: textColor, fontSize: 16),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: textColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: textColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.orange[800]!)),
        errorStyle: TextStyle(color: textColor),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: textColor)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $labelText';
        }
        return null;
      },
    );
  }
}
