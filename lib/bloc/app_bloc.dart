import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:bloc_statemanagment_examples/core/api/athenticaton_api.dart';
import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/core/models/sign_up_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SignUpApi signUpApi;
  final LoginApi loginApi;
  final NoteApi noteApi;

  AppBloc({
    required this.noteApi,
    required this.loginApi,
    required this.signUpApi,
  }) : super(const AppState.empty()) {
    // signing up the user
    on<SignUpEvent>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
          signUpError: null,
          signUpHandle: null,
        ),
      );
      // sign in the user
      final signUpHandle = await signUpApi.signUp(
        email: event.email,
        password: event.password,
      );
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          signUpError: signUpHandle == null ? SignUpError.invalidHandle : null,
          loginHandle: null,
          signUpHandle: signUpHandle,
          fetchedNotes: null,
        ),
      );
      // else we have valid login handle therefore fetch the notes
      // final notes = await noteApi.getNotes();
      // emit(
      //   AppState(
      //     isLoading: false,
      //     loginError: null,
      //     loginHandle: null,
      //     signUpHandle: signUpHandle,
      //     signUpError: null,
      //     fetchedNotes: notes,
      //   ),
      // );
    });

    // loading the notes
    on<LoginEvent>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
          signUpError: null,
          signUpHandle: null,
        ),
      );
      // sign in the user
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );
      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginError.invalidHandle : null,
          signUpError: null,
          signUpHandle: null,
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
          signUpError: null,
          signUpHandle: state.signUpHandle,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
      // get and check the login handle
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final loginHandle = state.loginHandle;
      if (loginHandle != LoginHandle.currenUser()) {
        emit(
          AppState(
            isLoading: false,
            loginError: LoginError.invalidHandle,
            signUpError: null,
            signUpHandle: null,
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
          signUpHandle: null,
          signUpError: null,
          fetchedNotes: notes,
        ),
      );
    });
  }
}
