import 'package:bitely_case_app/widgets/main_button_widget.dart';
import 'package:bitely_case_app/widgets/my_text_column_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import '../main_screens/create_or_edit_profile_screen.dart';

class YouAreInScreen extends StatelessWidget {
  const YouAreInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.sizeOf(context).width;

    return  Scaffold(
      backgroundColor: Colors.white,

        appBar: const AppBarWidget(),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 70, bottom: 50),
                child: MyTextColumnWidget(haveSpace:false, title: 'You Are In!', subTitle: 'We created your account successfully. Now you can go to the next step and create your profile.',),
              ),

              SizedBox(
                  width: sw,
                  height: 200,
                  child: Image.asset('assets/images/you_are_in.png', fit: BoxFit.cover,)),

              const SizedBox(height: 50,),

              ///Create Profile Button
              SizedBox(
                  width: sw - 50,
                  height: 45,
                  child: MainButtonWidget(onPressed: (){

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateOrEditProfileScreen()),
                    );

                  }, haveRadius: true,child: const Text("Create Profile"),))

            ],
          ),
        ),

      );

  }
}
