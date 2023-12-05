import 'package:bitely_case_app/providers/is_profile_created_provider.dart';
import 'package:bitely_case_app/providers/user_provider.dart';
import 'package:bitely_case_app/screens/main_screens/home_screen.dart';
import 'package:bitely_case_app/screens/main_screens/sign_up_screen.dart';
import 'package:bitely_case_app/utils/colors.dart';
import 'package:bitely_case_app/widgets/my_text_column_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'controllers/getx_is_profile_created_controller.dart';
import 'controllers/getx_user_details_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await GetStorage.init();
  IsProfileCreatedController isProfileCreatedController =
  Get.put(IsProfileCreatedController()); // Using GetX controller
  isProfileCreatedController.loadIsProfileCreated();
  //IsProfileCreatedProvider().loadIsProfileCreated(); //If the user has created a profile, it means that he has entered his information before. Using this information, the application can change dynamically depending on the user's situations.
  await Firebase.initializeApp();
  runApp(const BitelyCaseApp());
  FlutterNativeSplash.remove(); //Removes splash screen when process finish.
}


/*class BitelyCaseApp extends StatelessWidget {
  const BitelyCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
        ChangeNotifierProvider(create: (_) => IsProfileCreatedProvider()),
      ],
      child:
           MaterialApp(debugShowCheckedModeBanner: false, home: const MyHome(),)
    );
  }
}*/

class BitelyCaseApp extends StatelessWidget {
  const BitelyCaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
      initialBinding: BindingsBuilder(() {
        Get.put(UserDetailsController());
        Get.put(IsProfileCreatedController()); // Using GetX controller binding
      }),
    );
  }
}


/*class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    IsProfileCreatedProvider isProfileCreatedProvider =
        Provider.of<IsProfileCreatedProvider>(context, listen: false);
    //If the user has previously entered the application and created a profile, he/she will directly access the main screen.
    return isProfileCreatedProvider.isProfileCreated
        ? const HomeScreen()
        : OnBoardingSlider(
            pageBackgroundColor: Colors.white,
            headerBackgroundColor: Colors.white,
            finishButtonText: 'Start',
            finishButtonStyle: FinishButtonStyle(
              backgroundColor: MyColors.mainColor,
            ),
            onFinish: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpScreen()));
            },
            skipTextButton: const Text('Skip'),
            centerBackground: true,
            background: [
              Image.asset('assets/images/splash_1.png'),
              Image.asset('assets/images/splash_2.png'),
              Image.asset('assets/images/splash_3.png'),
            ],
            totalPage: 3,
            speed: 1.8,
            pageBodies: [
              MyTextColumnWidget(
                  title: 'It’s Time to Act',
                  subTitle:
                      'Experience knowledge hacks through a story, text, or audio setting, just on your fingertips.'),
              MyTextColumnWidget(
                  title: 'E-Learning Library',
                  subTitle:
                      'Anyone can learn with a customized learning workflow.Organize and assign training courses using our AI platform.'),
              MyTextColumnWidget(
                  title: 'Skill Mapping',
                  subTitle:
                      'Find out what your skills, capabilities, and gaps are so you can remain flexible and effective.')
            ],
          );
  }
}*/

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    IsProfileCreatedController isProfileCreatedController =
    Get.find<IsProfileCreatedController>(); // Accessing the controller

    return Obx(() {
      return isProfileCreatedController.isProfileCreated.value
          ? const HomeScreen()
          : OnBoardingSlider(
        pageBackgroundColor: Colors.white,
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Start',
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: MyColors.mainColor,
        ),
        onFinish: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignUpScreen()));
        },
        skipTextButton: const Text('Skip'),
        centerBackground: true,
        background: [
          Image.asset('assets/images/splash_1.png'),
          Image.asset('assets/images/splash_2.png'),
          Image.asset('assets/images/splash_3.png'),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          MyTextColumnWidget(
              title: 'It’s Time to Act',
              subTitle:
              'Experience knowledge hacks through a story, text, or audio setting, just on your fingertips.'),
          MyTextColumnWidget(
              title: 'E-Learning Library',
              subTitle:
              'Anyone can learn with a customized learning workflow.Organize and assign training courses using our AI platform.'),
          MyTextColumnWidget(
              title: 'Skill Mapping',
              subTitle:
              'Find out what your skills, capabilities, and gaps are so you can remain flexible and effective.')
        ],
      );
    });
  }
}
