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
class LoadNotesEvent implements AppEvent {
  const LoadNotesEvent();
}
