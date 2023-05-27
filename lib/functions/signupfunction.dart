import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mindque_location_app/view/screens/user_login_page/signin.dart';

signupfun({
  required String userpassword,
  required String useremail,
}) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: useremail,
    password: userpassword,
  );
  log('usercreated');

  Get.offAll(() => const Signin(),
      transition: Transition.circularReveal,
      duration: const Duration(seconds: 1));
}
