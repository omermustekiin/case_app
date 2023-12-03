import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_details_model.dart';
import 'firestore_db_service.dart';

//Burası Auth methods olduğu için profil ile ilgili bilgiler burada yer almaz ve bu bilgilerle bir işlem yapılmaz
class AuthMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreMethods firestoreMethods = CloudFirestoreMethods();


  //Password 8 character
  //Email format already checking by Firebase automatically
  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    email.trim();
    password.trim();
    String output = "Something went wrong!";

    if (email != "" && password != "") {
      if (password.length < 8) {
        output = "Password must be at least 8 character";
      } else {
        try {
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          UserDetailsModel user = UserDetailsModel(
            email: email,
          );
          await firestoreMethods.uploadNameToDatabase(user: user);
          output = "success";
        } on FirebaseAuthException catch (e) {
          output = e.message.toString();
        }
      }
    } else {
      output = "Please fill the all blanks";
    }
    return output;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    email.trim();
    password.trim();
    String output = "Something went wrong!";

    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill the all blanks";
    }
    return output;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  sendResetPassword({required String emailControllerText}) async {
    emailControllerText.trim().toString();
    String output = "Something went wrong!";

    if (emailControllerText != "") {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: emailControllerText);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill the all blanks";
    }
    return output;
  }

  Future updateEmail(String newEmail) async {
    String output =
        "This email is already in use or you must first log in again for this operation";
    try {
      User? firebaseUser = firebaseAuth.currentUser;
      await firebaseUser?.updateEmail(newEmail);
      output = "Saved Successfully";
    } on FirebaseAuthException catch (e) {
      output = e.message.toString();
    }
    return output;
  }

  Future updatePassword(String newPassword) async {
    String output = "Something went wrong!";
    try {
      User? firebaseUser = firebaseAuth.currentUser;
      await firebaseUser?.updatePassword(newPassword);
      output = "Saved Successfully";
    } on FirebaseAuthException catch (e) {
      output = e.message.toString();
    }
    return output;
  }
}
