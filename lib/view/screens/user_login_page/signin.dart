import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mindque_location_app/const/colors.dart';
import 'package:mindque_location_app/view/screens/Home/home.dart';
import 'package:mindque_location_app/view/screens/user_login_page/signin_page.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return SingleChildScrollView(
                child: Signinpage(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error Occured"),
              );
              // ignore: unnecessary_null_comparison
            } else if (snapshot.data != null || snapshot.data!.uid != null) {
              return Home();
            } else {
              return SingleChildScrollView(
                child: Signinpage(),
              );
            }
          }),
    );
  }
}
