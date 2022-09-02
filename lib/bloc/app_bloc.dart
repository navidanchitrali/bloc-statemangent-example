import 'package:bloc_statemanagment_examples/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final NoteApi noteApi;
  AppBloc({required this.noteApi}) : super(const AppState.empty()) {
    // loading the notes
    on<Loading>(
      (event, emit) => emit(AppState(fetchNotes: null)),
    );

    // load the note and emit and state

    on<LoadNotesEvent>((event, emit) async {
      print('LoadNotesEvent');
      final notes = await noteApi.getNotes();

      emit(AppState(fetchNotes: notes));
    });
  }
}
