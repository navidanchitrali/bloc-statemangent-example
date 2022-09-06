import 'package:bloc_statemanagment_examples/core/models/app_user.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/core/models/sign_up_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' show immutable;

@immutable
abstract class AuthenticationApiProtocol {
  const AuthenticationApiProtocol();

  // Future<SignUpLoginHandle?> signUpLogin({
  //   required String email,
  //   required String password,
  // });
}

class LoginApi implements AuthenticationApiProtocol {
  //final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  User? user;
  bool? isLogin;
  AppUser? appUser;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credentials.user!.uid.toString());
      return LoginHandle(token: credentials.user!.uid.toString());
    } catch (e) {
      print(e);
    }
  }
  // Future.delayed(
  //   const Duration(seconds: 2),
  //   () => email == 'foo@bar.com' && password == 'foobar',
  // ) .then(
  //   (isLogedIn) => isLogedIn ? const SignUpLoginHandle.foobar() : null,
  // );
}

class SignUpApi implements AuthenticationApiProtocol {
  final _auth = FirebaseAuth.instance;

  @override
  Future<SignUpHandle?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignUpHandle(token: 'FirebaseAuth.instance.currentUser!.uid');
    } catch (e) {
      print(e);
    }
  }
  //  =>
  //     Future.delayed(
  //       const Duration(seconds: 2),
  //       () => email == 'foo@bar.com' && password == 'foobar',
  //     ).then(
  //       (isLogedIn) => isLogedIn ? const SignUpLoginHandle.foobar() : null,
  //     );
}
