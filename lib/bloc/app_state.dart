import 'package:bloc_statemanagment_examples/core/models/add_task.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/core/models/notes.dart';
import 'package:bloc_statemanagment_examples/core/models/sign_up_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginError? loginError;
  final SignUpError? signUpError;
  final LoginHandle? loginHandle;
  final SignUpHandle? signUpHandle;
  final List<Note>? fetchedNotes;

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        signUpError = null,
        signUpHandle = null,
        fetchedNotes = null;

  const AppState(
      {required this.isLoading,
      required this.loginError,
      required this.loginHandle,
      required this.fetchedNotes,
      required this.signUpError,
      required this.signUpHandle});

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
