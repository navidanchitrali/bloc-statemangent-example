import 'package:bloc_statemanagment_examples/bloc/app_bloc.dart';
import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:bloc_statemanagment_examples/core/api/login_api.dart';
import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/generic_dialog.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/iterable_list_view.dart';
import 'package:bloc_statemanagment_examples/ui/screens/loading_screens.dart';
import 'package:bloc_statemanagment_examples/ui/screens/sign%20in/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MaterialApp(home: Homepage()));
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(loginapi: LoginApi(), noteApi: NoteApi()),
      child: Scaffold(
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Please wait',
              );
            } else {
              LoadingScreen.instance().hide();
            }
            // display if any error occur
            final error = appState.loginError;
            if (error != null) {
              showGenericDialog<bool>(
                context: context,
                title: 'Login error occured',
                content: 'Login error descroption',
                optionBuilder: () => {'ok': true},
              );
            }
            // loading the notes after login
            if (appState.isLoading == false &&
                appState.loginError == null &&
                appState.loginHandle == const LoginHandle.foobar() &&
                appState.fetchedNotes == null) {
              context.read<AppBloc>().add(const LoadNotesEvent());
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            if (notes == null) {
              return LoginScreen(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginEvent(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
