import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindque_location_app/const/colors.dart';
import 'package:mindque_location_app/const/const.dart';
import 'package:mindque_location_app/view/screens/user_login_page/signin.dart';
import 'package:mindque_location_app/view/screens/user_login_page/widgets/my_text_field.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final TextEditingController forgotPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Forgot password",
          ),
          centerTitle: true,
        ),
        backgroundColor: kwhite,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kheight30,
                    const Text(
                      "Enter the email associated with\nyour account and we'll send an\nemail with instructions to reset\nyour password",
                    ),
                    kheight30,
                    Mytextformfield(
                      preicon: Icons.email,
                      text: 'Email',
                      mycontroller: forgotPasswordController,
                      hide: false,
                    ),
                    kheight30,
                    GestureDetector(
                      onTap: () async {
                        var forgotEmail = forgotPasswordController.text.trim();
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: forgotEmail)
                              .then((value) {
                            log('Email send');
                            Get.off(() => const Signin());
                          });
                        } on FirebaseAuthException catch (e) {
                          log('Error $e');
                        }
                      },
                      child: Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                              color: kappbarcolor,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Text(
                              'Reset Passwod',
                            ),
                          )),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
