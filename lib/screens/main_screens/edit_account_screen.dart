import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../resources/firebase_auth_service.dart';
import '../../resources/firestore_db_service.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/main_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;
    Widget littleSpace = SizedBox(
      height: sh <= 668 ? sh * 0.022 : sh * 0.033,
    );


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(haveStringTitle: true, title: "Edit Your Account",),
      body: SafeArea(
        child: SizedBox(
          height: sh,
          width: sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ///Email
                    MyTextFieldWidget(
                      controller: emailController,
                      obscureText: false,
                      hintText: auth.currentUser!.email!,
                    ),
                    littleSpace,

                    ///Password
                    MyTextFieldWidget(
                      controller: passwordController,
                      obscureText: true,
                      hintText: 'Create a new password',
                    ),
                    littleSpace,


                    ///Save Button
                    SizedBox(
                        width: sw - 50,
                        height: 45,
                        child: MainButtonWidget(
                          onPressed: () async{
                            String output = await setUserInformation();
                            if (!mounted) return;
                            Utils().showSnackBar(
                                context: context, content: output, time: 4);
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          haveRadius: true,
                          child: const Text("Save"),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> setUserInformation() async {
    String output = "Nothing changed";
    try {
      if (emailController.text != "") {
        if (emailController.text.contains("@") &&
            emailController.text.contains(".com")) {
          output = await AuthMethods().updateEmail(emailController.text);
          if (output == "Saved Successfully") {
            await CloudFirestoreMethods().updateUserEmail(
              emailControllerText: emailController.text.trim(),
            );
          }
          setState(() {
            emailController.clear();
          });
        } else {
          output = "Please check your email address format";
        }
      }
      if (passwordController.text != "") {
        if (passwordController.text.length >= 8) {
          output = await AuthMethods().updatePassword(passwordController.text);
          setState(() {
            passwordController.clear();
          });
        } else {
          //getPasswordWarningMessage();
          output = "Password must be at least 8 character";
        }
      }
    } on FirebaseAuthException catch (e) {
      output = e.message.toString();
    }

    return output;
  }
}
