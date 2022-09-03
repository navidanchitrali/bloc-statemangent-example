import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/text%20feilds/email_text_feild.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/text%20feilds/password_text_feild.dart';
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

    return Padding(
      padding: const EdgeInsets.all(58),
      child: Column(
        children: [
          EmailTextFeild(
            emailController: emailController,
          ),
          PasswordTextFeild(passwordController: passwordController),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            onLoginTapped: onLoginTapped,
          )
        ],
      ),
    );
  }
}
