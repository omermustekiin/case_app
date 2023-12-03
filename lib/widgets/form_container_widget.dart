import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  final Widget child;
  const FormContainer({super.key, required this.child});

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;
    double sh= MediaQuery.sizeOf(context).height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: sw,
      height: sh,
      decoration: const BoxDecoration(
        color: Colors.red
      ),
      child: widget.child,
    );
  }
}