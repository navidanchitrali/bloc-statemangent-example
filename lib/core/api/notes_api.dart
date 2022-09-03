import 'package:bloc_statemanagment_examples/core/models/notes.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes();
}

@immutable
class NoteApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes() => Future.delayed(
        const Duration(seconds: 2),
        () => mocknotes,
      );
}
