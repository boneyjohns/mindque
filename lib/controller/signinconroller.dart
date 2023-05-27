import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Signincontroller extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signupformkey = GlobalKey<FormState>();

  String? validateemail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'please enter a valid email';
    }
    return null;
  }

  String? validatepassword(String value) {
    if (value.length < 6) {
      return 'please enter a valid password';
    }
    return null;
  }

  void checkLogin() {
    final isvalid = loginFormKey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    loginFormKey.currentState!.save();
  }

  void checkSignup() {
    final isvalid = signupformkey.currentState!.validate();
    if (!isvalid) {
      return;
    }
    signupformkey.currentState!.save();
  }
}
