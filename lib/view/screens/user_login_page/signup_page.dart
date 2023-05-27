import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindque_location_app/const/const.dart';
import 'package:mindque_location_app/controller/signinconroller.dart';
import 'package:mindque_location_app/functions/signupfunction.dart';
import 'package:mindque_location_app/view/screens/user_login_page/signin.dart';
import 'package:mindque_location_app/view/screens/user_login_page/widgets/my_text_field.dart';

final TextEditingController emailcontroller = TextEditingController();
final TextEditingController passwordcontroller = TextEditingController();

class SignUp extends StatelessWidget {
  SignUp({
    super.key,
  });
  final User? currentuser = FirebaseAuth.instance.currentUser;
  final signincontroller = Get.put(Signincontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Signup',
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: signincontroller.signupformkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                kheight20,
                Mytextformfield(
                    validator: (value) {
                      return signincontroller.validateemail(value ?? '');
                    },
                    hide: false,
                    keyboardtype: TextInputType.emailAddress,
                    text: 'Email',
                    preicon: Icons.mail,
                    mycontroller: emailcontroller),
                kheight20,
                Mytextformfield(
                    validator: (value) {
                      return signincontroller.validatepassword(value ?? '');
                    },
                    hide: true,
                    keyboardtype: TextInputType.visiblePassword,
                    text: 'Password',
                    preicon: Icons.lock,
                    mycontroller: passwordcontroller),
                kheight20,
                ElevatedButton(
                    onPressed: () async {
                      signincontroller.checkSignup();
                      await signupfun(
                          useremail: emailcontroller.text,
                          userpassword: passwordcontroller.text);
                    },
                    child: const Text(
                      'Create account',
                    )),
                GestureDetector(
                  onTap: () {
                    Get.off(() => const Signin());
                  },
                  child: const Card(
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Already have an account ",
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
