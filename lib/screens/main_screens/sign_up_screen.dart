import 'package:bitely_case_app/screens/interactive_messages_screens/you_are_in_screen.dart';
import 'package:bitely_case_app/utils/colors.dart';
import 'package:bitely_case_app/widgets/app_bar_widget.dart';
import 'package:bitely_case_app/widgets/main_button_widget.dart';
import 'package:flutter/material.dart';

import '../../resources/firebase_auth_service.dart';
import '../../utils/utils.dart';
import '../../widgets/form_container_widget.dart';
import '../../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<State> signUpKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthMethods authMethods = AuthMethods();
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;
    Widget littleSpace = SizedBox(
      height: sh <= 668 ? sh * 0.015 : sh * 0.030,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Title
                    Padding(
                      padding: EdgeInsets.only(
                        top: sh * 0.04,
                        left: sw >= 900 ? sw * 0.1 : sw * 0.06,
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: MyColors.mainColor,
                            fontSize: sw >= 900 ? 40 : 22,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0),
                      ),
                    ),
                    littleSpace,

                    ///Form Elements
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sw >= 900 ? sw * 0.1 : sw * 0.05,
                          vertical: 5),
                      child: Column(
                        children: [
                          ///Email
                          MyTextFieldWidget(
                            controller: emailController,
                            obscureText: false,
                            hintText: 'Email',
                          ),
                          littleSpace,

                          ///Password
                          MyTextFieldWidget(
                            controller: passwordController,
                            obscureText: true,
                            hintText: 'Password',
                          ),

                          littleSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///Sign Up Button
              SizedBox(
                key: signUpKey,
                width: sw,
                height: 45,
                child: MainButtonWidget(
                  onPressed: () async {
                    String output = await authMethods.signUpUser(
                        email: emailController.text.trim(),
                        password: passwordController.text);

                    if (output == "success") {
                      BuildContext? context = signUpKey.currentContext;
                      Navigator.pushReplacement(
                        context!,
                        MaterialPageRoute(
                            builder: (context) => const YouAreInScreen()),
                      );
                    } else {
                      if (!mounted) return;
                      Utils().showSnackBar(context: context, content: output);
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
