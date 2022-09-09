import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:bloc_statemanagment_examples/core/api/athenticaton_api.dart';
import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/models/add_task.dart';
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
  }) : super(AppState.empty()) {
    // signing up the user
    on<SignUpEvent>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
          signUpError: null,
          signUpHandle: null,
          isAddTaskButtonPressed: false,
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
          isAddTaskButtonPressed: false,
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
        AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
          signUpError: null,
          signUpHandle: null,
          isAddTaskButtonPressed: false,
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
          isAddTaskButtonPressed: false,
        ),
      );
    });

    // loading notes after logging in

    on<LoadTaskEvent>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginError: null,
          signUpError: null,
          signUpHandle: null,
          loginHandle: null,
          fetchedNotes: null,
          isAddTaskButtonPressed: false,
        ),
      );
      // get and check the login handle
      // final loginHandle = state.loginHandle;
      // if (loginHandle != LoginHandle.currenUser()) {
      //   emit(
      //     AppState(
      //       isLoading: false,
      //       loginError: LoginError.invalidHandle,
      //       signUpError: null,
      //       signUpHandle: null,
      //       loginHandle: loginHandle,
      //       fetchedNotes: null,
      //       isAddTaskButtonPressed: false,
      //     ),
      //   );
      //   return;
      //  }
      // else we have valid login handle therefore fetch the task
      final notes = await noteApi.getCurrentUserTask();
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: null,
          signUpHandle: null,
          signUpError: null,
          fetchedNotes: notes,
          isAddTaskButtonPressed: false,
        ),
      );
    });

    // adding new task of the user

    on<AddTaskEvent>(
      (event, emit) async {
        final notes = state.fetchedNotes;

        emit(
          AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            signUpHandle: null,
            signUpError: null,
            fetchedNotes: notes,
            isAddTaskButtonPressed: false,
          ),
        );
        FirebaseAuth auth = FirebaseAuth.instance;

        await noteApi.addTask(
          Task(
            id: auth.currentUser!.uid.toString(),
            taskTime: DateTime.now().toString(),
            taskTitle: event.taskTile,
            taskDescription: event.taskDescription,
          ),
        );

        final notes2 = await noteApi.getCurrentUserTask();
        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: null,
            signUpHandle: null,
            signUpError: null,
            fetchedNotes: notes2,
            isAddTaskButtonPressed: false,
          ),
        );
      },
    );

    // deleting user task
    on<DeleteTaskEvent>(
      (event, emit) async {
        final notes = state.fetchedNotes;
        emit(
          AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            signUpHandle: null,
            signUpError: null,
            fetchedNotes: notes,
            isAddTaskButtonPressed: false,
          ),
        );
        await noteApi.removeTask(docId: event.docId);
        final notes3 = await noteApi.getCurrentUserTask();

        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: null,
            signUpHandle: null,
            signUpError: null,
            fetchedNotes: notes3,
            isAddTaskButtonPressed: false,
          ),
        );
      },
    );
  }
}
