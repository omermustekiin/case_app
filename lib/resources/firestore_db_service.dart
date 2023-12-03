import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../models/user_details_model.dart';

class CloudFirestoreMethods {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  ///UPLOAD METHODS
  Future uploadNameToDatabase({required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .set(user.getJson());
  }

  ///GET METHODS

  Future getUserData() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .get();

    UserDetailsModel? userModel = snap.data() != null
        ? UserDetailsModel.getModelFromJson((snap.data() as dynamic))
        : null;

    return userModel ??
        UserDetailsModel(name: "user", email: "", age: 18, bio: "", gender: true, image: null);
  }

  ///UPDATE METHODS

  Future updateUserName({
    required String nameControllerText,
  }) async {
    DocumentReference documentReference = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid);

    Map<String, dynamic> updateData = {
      'name': nameControllerText,
    };
    documentReference.update(updateData);
  }

  Future updateUserEmail({
    required String emailControllerText,
  }) async {
    DocumentReference documentReference = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid);

    Map<String, dynamic> updateData = {
      'email': emailControllerText,
    };
    documentReference.update(updateData);
  }

  Future updateUserAge({
    required int ageControllerText,
  }) async {
    DocumentReference documentReference = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid);

    Map<String, dynamic> updateData = {
      'age': ageControllerText,
    };
    documentReference.update(updateData);
  }

  Future updateUserGender({
    required bool genderControllerValue,
  }) async {
    DocumentReference documentReference = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid);

    Map<String, dynamic> updateData = {
      'gender': genderControllerValue,
    };
    documentReference.update(updateData);
  }

  Future updateUserBio({
    required String bioControllerText,
  }) async {
    DocumentReference documentReference = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid);

    Map<String, dynamic> updateData = {
      'bio': bioControllerText,
    };
    documentReference.update(updateData);
  }


  //Not Use!
  Future updateUserImage({
    required Uint8List image,
  }) async {
    DocumentReference documentReference = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid);

    Map<String, dynamic> updateData = {
      'image': image,
    };
    documentReference.update(updateData);
  }

  ///DELETE METHODS
  Future deleteUserAccount() async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .delete();

    await FirebaseAuth.instance.currentUser?.delete();
  }
}
