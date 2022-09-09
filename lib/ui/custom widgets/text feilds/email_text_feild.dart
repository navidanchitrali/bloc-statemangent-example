import 'package:bloc_statemanagment_examples/core/constant/colors.dart';
import 'package:flutter/material.dart';

class EmailTextFeild extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextFeild({
    Key? key,
    required this.emailController,
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
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: const InputDecoration(
            border: InputBorder.none,
            icon: Icon(Icons.email),
            hintText: 'Email',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
