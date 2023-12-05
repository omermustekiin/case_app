import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class IsProfileCreatedController extends GetxController {
  RxBool isProfileCreated = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadIsProfileCreated();
  }

  void updateIsProfileCreated(bool newIsProfileCreated) {
    final box = GetStorage();
    box.write('isProfileCreated', newIsProfileCreated);
    isProfileCreated.value = newIsProfileCreated;
  }

  void loadIsProfileCreated() {
    final box = GetStorage();
    final savedIsProfileCreated = box.read('isProfileCreated') ?? false;
    isProfileCreated.value = savedIsProfileCreated;

  }
}
