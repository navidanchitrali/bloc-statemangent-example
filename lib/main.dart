import 'package:bloc_statemanagment_examples/bloc/app_bloc.dart';
import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:bloc_statemanagment_examples/core/api/athenticaton_api.dart';
import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/constant/colors.dart';
import 'package:bloc_statemanagment_examples/core/models/login_model.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/generic_dialog.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/task_dialog.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/iterable_list_view.dart';
import 'package:bloc_statemanagment_examples/ui/screens/add%20task/add_task_screen.dart';
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
        backgroundColor: blueFadeColor,
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

            if (appState.isLoading == false && appState.fetchedNotes == null) {
              context.read<AppBloc>().add(const LoadTaskEvent());
            }
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
            if (notes == null &&
                auth.currentUser != null &&
                appState.signUpHandle == null) {
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
            }
            if (appState.isAddTaskButtonPressed) {
              return AddTaskScreen(
                onAddTaskTapped: ((taskTitle, taskDescription) {
                  context.read<AppBloc>().add(
                        AddTaskEvent(
                          taskTile: taskTitle,
                          taskDescription: taskDescription,
                        ),
                      );
                }),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: notes!.length,
                        itemBuilder: ((context, index) => ExpansionTile(
                              leading: Checkbox(
                                activeColor: Colors.blue,
                                value: notes[index].isDone,
                                onChanged: (newValue) {
                                  notes[index].isDone = newValue;
                                  setState(() {});
                                  Future.delayed(const Duration(seconds: 1))
                                      .then(
                                    (value) => context.read<AppBloc>().add(
                                          DeleteTaskEvent(
                                            docId: notes[index].docId!,
                                          ),
                                        ),
                                  );
                                },
                              ),
                              backgroundColor: blueFadeColor,
                              title: Container(
                                padding: const EdgeInsets.all(13),
                                decoration: BoxDecoration(
                                  color: lightYumColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  notes[index].taskTitle!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: lightYumColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      notes[index].taskDescription!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          appState.isAddTaskButtonPressed = true;
                          setState(() {});
                        },
                        child: const Icon(Icons.add),
                      ),
                    )
                  ],
                ),
              );
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
