import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

typedef OnSignUpTapped = void Function(
  String email,
  String password,
);

class SignUpButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnSignUpTapped onLoginTapped;
  const SignUpButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;
        if (email.isEmpty || password.isEmpty) {
          showGenericDialog<bool>(
            context: context,
            title: 'Email and password should not be empty',
            content: 'Please enter both the email and password',
            optionBuilder: () => {'ok': true},
          );
        } else {
          onLoginTapped(
            email,
            password,
          );
        }
      },
      child: const Text('Sign Up'),
    );
  }
}
