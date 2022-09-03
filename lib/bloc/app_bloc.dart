import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:bloc_statemanagment_examples/core/api/login_api.dart';
import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final LoginApiProtocol loginapi;
  final NotesApiProtocol noteApi;

  AppBloc({
    required this.noteApi,
    required this.loginapi,
  }) : super(const AppState.empty()) {
    // loading the notes
    on<LoginEvent>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );
      // sign in the user
      final loginHandle = await loginapi.login(
        email: event.email,
        password: event.password,
      );
      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginError.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    // loading notes after logging in

    on<LoadNotesEvent>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
      // get and check the login handle
      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.foobar()) {
        emit(
          AppState(
            isLoading: false,
            loginError: LoginError.invalidHandle,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
        return;
      }
      // else we have valid login handle therefore fetch the notes
      final notes = await noteApi.getNotes();
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: loginHandle,
          fetchedNotes: notes,
        ),
      );
    });
  }
}
