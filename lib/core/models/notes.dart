import 'package:flutter/foundation.dart' show immutable;

@immutable
class Note {
  String title;

  Note({required this.title});

  @override
  String toString() => 'Note tile ($title)';
}

final mocknotes = List.generate(3, ((index) => Note(title: 'Note : $index')));
