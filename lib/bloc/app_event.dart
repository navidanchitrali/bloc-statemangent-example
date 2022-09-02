import 'package:flutter/cupertino.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class Loading implements AppEvent {
  const Loading();
}

@immutable
class LoadNotesEvent implements AppEvent {
  const LoadNotesEvent();
}
