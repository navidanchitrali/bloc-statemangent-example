import 'package:bloc_statemanagment_examples/bloc/app_bloc.dart';
import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:bloc_statemanagment_examples/core/api/athenticaton_api.dart';
import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/core/models/sign_up_model.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/generic_dialog.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/iterable_list_view.dart';
import 'package:bloc_statemanagment_examples/ui/screens/loading_screens.dart';
import 'package:bloc_statemanagment_examples/ui/screens/sign%20in/login_screen.dart';
import 'package:bloc_statemanagment_examples/ui/screens/sign%20up/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      create: (context) => AppBloc(
        signUpApi: SignUpApi(),
        loginApi: LoginApi(),
        noteApi: NoteApi(),
      ),
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
            // display if login error occur
            final error = appState.loginError;
            if (error != null) {
              showGenericDialog<bool>(
                context: context,
                title: 'Login error occured',
                content: error.toString(),
                optionBuilder: () => {'ok': true},
              );
            }
            // display if sign up error occur
            final error2 = appState.signUpError;
            if (error2 != null) {
              showGenericDialog<bool>(
                context: context,
                title: 'Sign up error occured',
                content: 'Sign up error descroption',
                optionBuilder: () => {'ok': true},
              );
            }
            // loading the notes after login
            // if (appState.isLoading == false &&
            //     appState.loginError == null &&
            //     appState.loginHandle == LoginHandle.currenUser() &&
            //     appState.fetchedNotes == null) {
            //   context.read<AppBloc>().add(const LoadNotesEvent());
            // }
            if (appState.isLoading == false &&
                appState.fetchedNotes == null &&
                appState.loginHandle == LoginHandle.currenUser()) {
              context.read<AppBloc>().add(const LoadNotesEvent());
            }
            // loading the notes after sign up
            // if (appState.isLoading == false &&
            //     appState.loginError == null &&
            //     appState.loginHandle == null &&
            //     appState.signUpHandle == SignUpHandle.currentUser() &&
            //     appState.fetchedNotes == null) {
            // context.read<AppBloc>().add(const LoadNotesEvent());
            // }
          },
          builder: (context, appState) {
            final notes = appState.fetchedNotes;
            final FirebaseAuth auth = FirebaseAuth.instance;
            if (notes == null && auth.currentUser == null) {
              return SignUpScreen(
                onSignUpTapped: (email, password) {
                  context.read<AppBloc>().add(
                        SignUpEvent(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            }
            // ignore: unnecessary_null_comparison
            if (notes == null && auth.currentUser != null) {
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
              return notes!.toListView();
            }
            //    else {
            //     return Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const Text('Check your internet connection'),
            //         const SizedBox(
            //           height: 30,
            //         ),
            //         TextButton(
            //             onPressed: () {
            //               // Navigator.of(context).push(
            //               //   MaterialPageRoute(
            //               //     builder: (context) {
            //               //       return SignUpScreen(
            //               //         onSignUpTapped: (email, password) {
            //               //           context.read<AppBloc>().add(
            //               //                 SignUpEvent(
            //               //                   email: email,
            //               //                   password: password,
            //               //                 ),
            //               //               );
            //               //         },
            //               //       );
            //               //     },
            //               //   ),
            //               // );
            //             },
            //             child: const Text('Try Again'))
            //       ],
            //     );
            //   }
          },
        ),
      ),
    );
  }
}
