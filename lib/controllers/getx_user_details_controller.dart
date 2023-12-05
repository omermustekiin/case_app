import 'package:get/get.dart';

import '../models/user_details_model.dart';
import '../resources/firestore_db_service.dart';

class UserDetailsController extends GetxController {
 //UserDetailsModel? userDetails;
  Rx<UserDetailsModel?> userDetails = Rx<UserDetailsModel?>(null);

/*  @override
  void onInit() {
    super.onInit();
    // user information will come null when the situation is beginning.
    userDetails = null;
  }*/

  Future<void> getUserData() async {
    UserDetailsModel? userData = await CloudFirestoreMethods().getUserData();
    userDetails.value = userData; // Assign the fetched userDetails to value
    update(); // Notifies listeners about the changes
  }
}