import 'package:flutter/material.dart';

class MyTextColumnWidget extends StatelessWidget {
  String title;
  String subTitle;
  bool haveSpace;
  MyTextColumnWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.haveSpace = true});

  @override
  Widget build(BuildContext context) {
    TextStyle titleTextStyle = const TextStyle(
        fontWeight: FontWeight.w600, letterSpacing: 0.3, fontSize: 20);
    TextStyle subTitleTextStyle = const TextStyle(
      fontSize: 16,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          haveSpace
              ? const SizedBox(
                  height: 400,
                )
              : Container(),
          Text(title, style: titleTextStyle),
          const SizedBox(
            height: 20,
          ),
          Text(
            subTitle,
            style: subTitleTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
