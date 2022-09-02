import 'package:bloc_statemanagment_examples/models.dart';
import 'package:flutter/cupertino.dart';

// @immutable
// abstract class NotesApiProtocol {
//   const NotesApiProtocol();
//   Future<Iterable<Note>?> getNotes();
// }

@immutable
class NoteApi {
  // @override
  Future<Iterable<Note>?> getNotes() => Future.delayed(
      const Duration(seconds: 2),
      () => Iterable.generate(3, ((index) => Note(title: 'Note : $index'))));
}
