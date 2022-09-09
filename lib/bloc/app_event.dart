import 'dart:ui';

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
class AddTaskEvent implements AppEvent {
  final String taskTile;
  final String taskDescription;
  const AddTaskEvent({required this.taskTile, required this.taskDescription});
}

@immutable
class LoadTaskEvent implements AppEvent {
  const LoadTaskEvent();
}

@immutable
class DeleteTaskEvent implements AppEvent {
  final String docId;
  const DeleteTaskEvent({
    required this.docId,
  });
}
