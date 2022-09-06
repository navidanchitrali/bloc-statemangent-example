import 'package:firebase_auth/firebase_auth.dart';

class LoginHandle {
  final String token;

  LoginHandle({required this.token});
  LoginHandle.currenUser() : token = FirebaseAuth.instance.currentUser!.uid;

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashcode => token.hashCode;

  @override
  String toString() => 'Login Handle (token = $token)';
}

enum LoginError { invalidHandle }
