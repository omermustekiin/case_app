import 'dart:typed_data';
import 'package:bitely_case_app/providers/is_profile_created_provider.dart';
import 'package:bitely_case_app/resources/firestore_db_service.dart';
import 'package:bitely_case_app/screens/interactive_messages_screens/profile_created_successfully_screen.dart';
import 'package:bitely_case_app/screens/main_screens/home_screen.dart';
import 'package:bitely_case_app/widgets/gender_boxes_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../models/user_details_model.dart';
import '../../providers/user_provider.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/main_button_widget.dart';
import '../../widgets/text_field_widget.dart';

class CreateOrEditProfileScreen extends StatefulWidget {
  const CreateOrEditProfileScreen({super.key});

  @override
  State<CreateOrEditProfileScreen> createState() =>
      _CreateOrEditProfileScreenState();
}

class _CreateOrEditProfileScreenState extends State<CreateOrEditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  late ValueNotifier<bool> genderController = ValueNotifier<bool>(true);
  final TextEditingController bioController = TextEditingController();
  Uint8List? image;    //it should come from user detail model

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getUserData();
    UserDetailsModel? userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    double sw = MediaQuery.sizeOf(context).width;
    double sh = MediaQuery.sizeOf(context).height;

    Widget littleSpace = SizedBox(
      height: sh <= 668 ? sh * 0.015 : sh * 0.025,
    );

    return Consumer<IsProfileCreatedProvider>(
        builder: (context, isProfileCreatedProvider, _) {
          bool isProfileCreated = isProfileCreatedProvider.isProfileCreated;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWidget(
              haveStringTitle: true,
              title: isProfileCreated ? "Edit Your Profile" : "Create Your Profile",
            ),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: sh,
                    width: sw,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///Image
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CircleAvatar(
                                radius: sh / 16, // Set a fixed radius for the CircleAvatar
                                backgroundColor: Colors.transparent,
                                backgroundImage: image == null
                                    ? const AssetImage("assets/images/default_profile_picture.png") as ImageProvider
                                    : MemoryImage(image!),
                                child: GestureDetector(
                                  onTap: () async {
                                    Uint8List? temp = await pickImage();
                                    if (temp != null) {
                                      setState(() {
                                        image = temp;
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: sh / 60,
                                      child: const Icon(
                                        Icons.photo_camera,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          littleSpace,
                          Column(
                            children: [
                              ///Name Surname
                              MyTextFieldWidget(
                                controller: nameController,
                                obscureText: false,
                                hintText: isProfileCreated
                                    ? '${userDetails?.name}'
                                    : 'Name Surname',
                              ),
                              littleSpace,

                              ///Age
                              MyTextFieldWidget(
                                controller: ageController,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                hintText: isProfileCreated
                                    ? '${userDetails?.age}'
                                    : 'Age',
                              ),
                              littleSpace,

                              ///Gender (it cant change after )
                              Row(
                                children: [
                                  GenderBoxesWidget(
                                    controller: isProfileCreated
                                        ? userDetails != null
                                        ? ValueNotifier<bool>(
                                        userDetails.gender ?? true)
                                        : ValueNotifier<bool>(
                                        true) //default is male
                                        : genderController,
                                  ),
                                  if (!isProfileCreated)
                                    const Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "It cannot be changed again",
                                              style: TextStyle(
                                                  color: Colors.grey, fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                ],
                              ),
                              littleSpace,

                              ///Bio
                              SizedBox(
                                height: 150,
                                child: MyTextFieldWidget(
                                  controller: bioController,
                                  obscureText: false,
                                  hintText: isProfileCreated
                                      ? '${userDetails?.bio}'
                                      : 'Biography',
                                  haveNeedMoreSpace: true,
                                ),
                              ),
                              littleSpace,

                              ///Save Button
                              SizedBox(
                                  width: sw - 50,
                                  height: 45,
                                  child: MainButtonWidget(
                                    onPressed: ()async{
                                      await onPressedSaveButton(isProfileCreated, userDetails!);
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
              ),
            ),
          );
        });
  }


  Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.readAsBytes();
    } else {
      return null;
    }
  }
  Future<void Function()?> onPressedSaveButton(bool isProfileCreated,  UserDetailsModel userDetails)async{
   // await CloudFirestoreMethods().updateUserImage(image: image);

    String output = "";
    int age = int.tryParse(ageController.text) ?? 0;
    // Check if it's a new profile creation or editing an existing profile
    if (!isProfileCreated) {
      if (nameController.text.isNotEmpty &&
          ageController.text.isNotEmpty &&
          bioController.text.isNotEmpty) {
        await checkConditionsAndRun(age, output,
        isProfileCreated, userDetails);
      } else {
        output = "Please fill in all fields";
        Utils().showSnackBar(
            context: context, content: output);
      }
    } else {
      // For editing an existing profile, no need to check for empty fields
      await checkConditionsAndRun(age, output,
      isProfileCreated, userDetails);
    }
    return null;

  }

  Future<void> checkConditionsAndRun(int age, String output,
      bool isProfileCreated, UserDetailsModel userDetails) async {
    if (!isProfileCreated) {
      // Check for new profile creation
      if (age < 18) {
        output = "Your age must be at least 18";
        Utils().showSnackBar(context: context, content: output);
        return;
      } else if (bioController.text.length < 60) {
        output = "Biography must be at least 60 characters";
        Utils().showSnackBar(context: context, content: output);
        return;
      } else {
        // All conditions for creating a new profile are met
        await updateAllUserData(age);
        if (!mounted) return;
        Provider.of<IsProfileCreatedProvider>(context, listen: false)
            .updateIsProfileCreated(true);
      }
    } else {
      // Editing an existing profile
      if (age < 18 && age != userDetails.age && ageController.text.isNotEmpty) {
        // If trying to change age to less than 18
        output = "Your age must be at least 18";
        Utils().showSnackBar(context: context, content: output);
        return;
      }

      // Update individual fields if they are modified
      if (ageController.text.isNotEmpty && age != userDetails.age) {
        await CloudFirestoreMethods().updateUserAge(ageControllerText: age);
      }
      if (nameController.text.isNotEmpty &&
          nameController.text != userDetails.name) {
        await CloudFirestoreMethods()
            .updateUserName(nameControllerText: nameController.text);
      }
      if (bioController.text.isNotEmpty &&
          bioController.text != userDetails.bio) {
        if (bioController.text.length < 60) {
          output = "Biography must be at least 60 characters";
          if (!mounted) return;
          Utils().showSnackBar(context: context, content: output);
          return;
        }
        await CloudFirestoreMethods()
            .updateUserBio(bioControllerText: bioController.text);
      }
    }

    // Navigate to the appropriate screen based on the action
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isProfileCreated
              ? const HomeScreen()
              : const ProfileCreatedSuccessfullyScreen(),
        ),
      );
    }
  }

  updateAllUserData(int age) async {
    await CloudFirestoreMethods()
        .updateUserName(nameControllerText: nameController.text);
    await CloudFirestoreMethods().updateUserAge(ageControllerText: age);
    await CloudFirestoreMethods()
        .updateUserBio(bioControllerText: bioController.text);
    await CloudFirestoreMethods()
        .updateUserGender(genderControllerValue: genderController.value);
  }
}
