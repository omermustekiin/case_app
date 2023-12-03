import 'package:flutter/widgets.dart';
import 'package:prefs/prefs.dart';

class IsProfileCreatedProvider extends ChangeNotifier {
  bool isProfileCreated = false;

  IsProfileCreatedProvider() {
    loadIsProfileCreated();
  }

  void updateIsProfileCreated(bool newIsProfileCreated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isProfileCreated', newIsProfileCreated);
    isProfileCreated = newIsProfileCreated;
    loadIsProfileCreated();
    notifyListeners();
  }

  void loadIsProfileCreated() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIsProfileCreated = prefs.getBool('isProfileCreated') ?? false;
    isProfileCreated = savedIsProfileCreated;
    notifyListeners();

  }
}