import 'package:flutter/material.dart';

import '../models/user_details_model.dart';
import '../resources/firestore_db_service.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel? userDetails;

  ///for null error
/*  UserDetailsProvider()
      : userDetails = UserDetailsModel(
          name: "null user",
          email: "",
          age: 0,
          gender: true,
          bio: "",
          image: null,
        );*/

  UserDetailsProvider() : userDetails = null;

  Future getUserData() async {
    userDetails = await CloudFirestoreMethods().getUserData();
    notifyListeners();
  }
}
