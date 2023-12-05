import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../controllers/getx_user_details_controller.dart';
import '../providers/user_provider.dart';

class GenderBoxesWidget extends StatefulWidget {
  final ValueNotifier<bool> controller;


  const GenderBoxesWidget({super.key, required this.controller});

  @override
  GenderBoxesWidgetState createState() => GenderBoxesWidgetState();
}

class GenderBoxesWidgetState extends State<GenderBoxesWidget> {
  @override
  Widget build(BuildContext context) {
    final UserDetailsController userDetailsController =
    Get.find<UserDetailsController>();
    userDetailsController.getUserData();
    //Provider.of<UserDetailsProvider>(context).getUserData();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value = true;
            });
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: widget.controller.value ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.male,
                  size: 34,
                  color: widget.controller.value ? Colors.white : Colors.black,
                ),
                const SizedBox(height: 5),
                Text(
                  'Male',
                  style: TextStyle(
                    color: widget.controller.value ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value = false;
            });
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: widget.controller.value ? Colors.grey[300] : Colors.pink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.female,
                  size: 34,
                  color: widget.controller.value ? Colors.black : Colors.white,
                ),
                const SizedBox(height: 5),
                Text(
                  'Female',
                  style: TextStyle(
                    color: widget.controller.value ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
