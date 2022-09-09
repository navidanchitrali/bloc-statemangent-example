import 'package:bloc_statemanagment_examples/core/models/add_task.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/core/models/sign_up_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
// ignore: must_be_immutable
class AppState {
  final bool isLoading;
  final LoginError? loginError;
  final SignUpError? signUpError;
  final LoginHandle? loginHandle;
  final SignUpHandle? signUpHandle;
  List<Task>? fetchedNotes;
  bool isAddTaskButtonPressed;

  AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        signUpError = null,
        signUpHandle = null,
        isAddTaskButtonPressed = false,
        fetchedNotes = null;

  AppState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    this.fetchedNotes,
    required this.signUpError,
    required this.signUpHandle,
    required this.isAddTaskButtonPressed,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'LoginErrors': loginError,
        'LoginHandle': loginHandle,
        'signUpError': signUpError,
        'SignUpHandle': signUpHandle,
        'fetchedNotes': fetchedNotes,
      }.toString();
}
