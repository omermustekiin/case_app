import 'package:flutter/material.dart';

import '../utils/colors.dart';


class MyTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Color backgroundColor = Colors.transparent;
  final bool haveNeedMoreSpace;
  final TextInputType? keyboardType;

  const MyTextFieldWidget({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,  this.haveNeedMoreSpace = false,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: MyColors.mainColor,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: haveNeedMoreSpace ? 5 : 1,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle:  TextStyle(
          color: Colors.grey[700]!,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.black,
            strokeAlign: 1,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.mainColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}