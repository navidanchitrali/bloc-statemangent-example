import 'package:flutter/cupertino.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LoginEvent implements AppEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class SignUpEvent implements AppEvent {
  final String email;
  final String password;

  const SignUpEvent({
    required this.email,
    required this.password,
  });
}

@immutable
class addNotesEvent implements AppEvent {
  const addNotesEvent();
}

@immutable
class LoadNotesEvent implements AppEvent {
  const LoadNotesEvent();
}
