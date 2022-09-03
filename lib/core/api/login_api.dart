import 'dart:ui';

import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:flutter/cupertino.dart' show immutable;

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

class LoginApi implements LoginApiProtocol {
  // const LoginApi._sharedInstance();
  // static const LoginApi _shared = LoginApi._sharedInstance();
  // factory LoginApi.instance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then(
        (isLogedIn) => isLogedIn ? const LoginHandle.foobar() : null,
      );
}
