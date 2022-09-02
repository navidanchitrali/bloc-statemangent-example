import 'package:flutter/cupertino.dart';

@immutable
class Note {
  String title;

  Note({required this.title});

  @override
  String toString() => 'Note tile ($title)';
}
