import 'package:flutter/material.dart';

class PasswordTextFeild extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextFeild({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Enter your password',
      ),
    );
  }
}
