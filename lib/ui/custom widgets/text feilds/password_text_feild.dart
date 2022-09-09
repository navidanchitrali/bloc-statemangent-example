import 'package:bloc_statemanagment_examples/core/constant/colors.dart';
import 'package:flutter/material.dart';

class PasswordTextFeild extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextFeild({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: lightYumColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.password),
            hintText: 'Password',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
