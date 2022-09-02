import 'package:bloc_statemanagment_examples/models.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final Iterable<Note>? fetchNotes;

  const AppState.empty() : fetchNotes = null;

  const AppState({
    required this.fetchNotes,
  });
}
