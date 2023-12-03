import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double iconWidth;
  final bool haveStringTitle;
  final String title;
  const AppBarWidget({super.key,  this.iconWidth = 140,  this.haveStringTitle = false, this.title=""});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: haveStringTitle ? Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.3,),) : SizedBox(
          width: iconWidth,
          child: Image.asset('assets/images/bitely_logo.png',
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}