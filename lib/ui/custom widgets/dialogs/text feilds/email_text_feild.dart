import 'package:flutter/material.dart';

class EmailTextFeild extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextFeild({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: const InputDecoration(
        hintText: 'Enter your email',
      ),
    );
  }
}
