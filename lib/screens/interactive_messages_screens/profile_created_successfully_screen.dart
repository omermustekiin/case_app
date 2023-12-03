import 'package:bitely_case_app/widgets/main_button_widget.dart';
import 'package:bitely_case_app/widgets/my_text_column_widget.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bar_widget.dart';
import '../main_screens/home_screen.dart';

class ProfileCreatedSuccessfullyScreen extends StatelessWidget {
  const ProfileCreatedSuccessfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        iconWidth: 120,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 70, bottom: 50),
              child: MyTextColumnWidget(
                haveSpace: false,
                title: 'Profile Created Successfully',
                subTitle:
                    'We created your profile                                                                                                                                                                                                                                                                                                                                                                                                                                                      successfully. Now you can visit your profile and make any changes. Time to discover our app!',
              ),
            ),

            SizedBox(
                width: sw,
                height: 220,
                child: Image.asset(
                  'assets/images/profile_created_successfully.png',
                  fit: BoxFit.cover,
                )),

            const SizedBox(
              height: 50,
            ),

            ///Start Button
            SizedBox(
                width: sw - 50,
                height: 45,
                child: MainButtonWidget(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  haveRadius: true,
                  child: const Text("Start"),
                ))
          ],
        ),
      ),
    );
  }
}
