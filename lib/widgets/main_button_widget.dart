import 'package:bitely_case_app/utils/colors.dart';
import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  final Widget child;
  final bool haveRadius;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const MainButtonWidget(
      {super.key,
        required this.child,
         this.haveRadius = false,
        // required this.isLoading,
        required this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? MyColors.mainColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape:
          RoundedRectangleBorder(borderRadius: haveRadius ? BorderRadius.circular( 10 ) : BorderRadius.circular( 0 ) ),
        ),
        onPressed: onPressed,
        child: child);
  }
}