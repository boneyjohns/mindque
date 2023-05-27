import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindque_location_app/const/const.dart';
import 'package:mindque_location_app/controller/signinconroller.dart';
import 'package:mindque_location_app/functions/email_login.dart';
import 'package:mindque_location_app/view/screens/user_login_page/forgetpassword.dart';
import 'package:mindque_location_app/view/screens/user_login_page/signup_page.dart';
import 'package:mindque_location_app/view/screens/user_login_page/widgets/my_text_field.dart';

class Signinpage extends StatelessWidget {
  Signinpage({
    super.key,
  });
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final signincontroller = Get.put(Signincontroller());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'Login',
          ),
        ),
        kheight20,
        Form(
          key: signincontroller.loginFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(children: [
            Mytextformfield(
              validator: (value) {
                return signincontroller.validateemail(value ?? '');
              },
              hide: false,
              keyboardtype: TextInputType.emailAddress,
              text: 'Email',
              preicon: Icons.mail,
              mycontroller: emailcontroller,
            ),
            kheight20,
            Mytextformfield(
                validator: (value) {
                  return signincontroller.validatepassword(value ?? '');
                },
                keyboardtype: TextInputType.visiblePassword,
                text: 'passsword',
                preicon: Icons.lock,
                hide: true,
                mycontroller: passwordcontroller),
          ]),
        ),
        kheight20,
        InputChip(
            onPressed: () async {
              signincontroller.checkLogin;

              await emaillogin(
                  useremail: emailcontroller.text.trim(),
                  userpassword: passwordcontroller.text.trim());
            },
            label: const SizedBox(
              width: 200,
              child: Center(
                child: Text(
                  'Login',
                ),
              ),
            )),
        kheight10,
        GestureDetector(
          onTap: () {
            Get.to(() => SignUp(),
                transition: Transition.circularReveal,
                duration: const Duration(seconds: 1));
          },
          child: const Card(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Don't have an account signUp",
                )),
          ),
        ),
        GestureDetector(
          onTap: () => Get.to(ForgotPassword()),
          child: const Card(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Forgot password",
                )),
          ),
        )
      ],
    );
  }
}
