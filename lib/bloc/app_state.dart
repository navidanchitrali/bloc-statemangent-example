import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/core/models/notes.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginError? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.fetchedNotes,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'LoginErrors': loginError,
        'LoginHandle': LoginHandle,
        'fetchedNotes': fetchedNotes,
      }.toString();
}
