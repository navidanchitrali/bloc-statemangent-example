import 'package:firebase_auth/firebase_auth.dart';

class SignUpHandle {
  final String token;
  SignUpHandle({required this.token});
  SignUpHandle.currentUser() : token = 'wvtTEGEcunUKjBMI1AukQ8VBDW62';

  @override
  bool operator ==(covariant SignUpHandle other) => token == other.token;

  @override
  int get hashcode => token.hashCode;

  @override
  String toString() => 'Login Handle (token = $token)';
}

enum SignUpError { invalidHandle }
