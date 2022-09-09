import 'package:bloc_statemanagment_examples/core/constant/colors.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/text%20feilds/email_text_feild.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/text%20feilds/password_text_feild.dart';
import 'package:bloc_statemanagment_examples/ui/screens/sign%20in/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginScreen extends HookWidget {
  final OnLoginTapped onLoginTapped;
  const LoginScreen({Key? key, required this.onLoginTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: lightYumColor,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(300)),
            ),
            height: 250,
            child: const Padding(
              padding: EdgeInsets.only(right: 220),
              child: Center(
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: blueFadeColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: EmailTextFeild(
              emailController: emailController,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: PasswordTextFeild(passwordController: passwordController),
          ),
          const SizedBox(
            height: 30,
          ),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            onLoginTapped: onLoginTapped,
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: const BoxDecoration(
              color: lightYumColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(300),
                // topRight: Radius.circular(300),
              ),
            ),
            height: 140,
            child: Center(
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    SizedBox(
                      width: 130,
                    ),
                    Icon(
                      Icons.arrow_back,
                      color: blueFadeColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Back to Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: blueFadeColor,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
