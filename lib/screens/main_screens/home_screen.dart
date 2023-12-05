import 'package:bitely_case_app/providers/is_profile_created_provider.dart';
import 'package:bitely_case_app/resources/firestore_db_service.dart';
import 'package:bitely_case_app/screens/main_screens/create_or_edit_profile_screen.dart';
import 'package:bitely_case_app/screens/main_screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../controllers/getx_is_profile_created_controller.dart';
import '../../controllers/getx_user_details_controller.dart';
import '../../models/user_details_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/main_button_widget.dart';
import 'edit_account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
/*    Provider.of<UserDetailsProvider>(context).getUserData();
    UserDetailsModel? userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;*/
    final UserDetailsController userDetailsController =
        Get.find<UserDetailsController>();
    userDetailsController.getUserData();

    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;
    Widget littleSpace = SizedBox(
      height: sh <= 668 ? sh * 0.022 : sh * 0.033,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 50),
          child: Column(
            children: [
              ///Welcome Text
              Obx(() {
                return Text(
                  'Hello: ${userDetailsController.userDetails.value?.name}',
                  style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w600),
                );
              }),
              /*   Text(
                "Hello ${userDetails?.name}!",
                style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w600),
              ),*/

              const SizedBox(
                height: 50,
              ),

              ///Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ///Visit and Edit Your Profile Button
                  SizedBox(
                      width: sw - 50,
                      height: 45,
                      child: MainButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateOrEditProfileScreen()),
                          );
                        },
                        haveRadius: true,
                        child: const Text("Visit and Edit Your Profile"),
                      )),
                  littleSpace,

                  ///Visit and Edit Your Account Button
                  SizedBox(
                      width: sw - 50,
                      height: 45,
                      child: MainButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditAccountScreen()),
                          );
                        },
                        haveRadius: true,
                        child: const Text("Visit and Edit Your Account"),
                      )),
                  littleSpace,

                  ///Delete Account Button
                  SizedBox(
                      width: sw - 50,
                      height: 45,
                      child: MainButtonWidget(
                        onPressed: () async {

                          await CloudFirestoreMethods().deleteUserAccount();
                          if (!mounted) return;
                         // Provider.of<IsProfileCreatedProvider>(context, listen: false).updateIsProfileCreated(false);
                          IsProfileCreatedController isProfileCreatedController =
                          Get.find<IsProfileCreatedController>();
                          isProfileCreatedController.updateIsProfileCreated(true);


                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        haveRadius: true,
                        backgroundColor: Colors.red,
                        child: const Text("Delete Your Account"),
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
