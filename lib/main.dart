import 'package:bloc_statemanagment_examples/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/bloc/app_bloc.dart';
import 'package:bloc_statemanagment_examples/bloc/app_event.dart';
import 'package:bloc_statemanagment_examples/bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(home: const Homepage()));
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
        create: (context) => AppBloc(noteApi: NoteApi()),
        child: Scaffold(
            body: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            print('listeningggggggg');
            if (state.fetchNotes == null) {
              context.read<AppBloc>().add(const LoadNotesEvent());
            }
          },
          builder: (context, state) {
            final notes = state.fetchNotes;
            if (notes == null) {
              context.read<AppBloc>().add(const Loading());
              return Container(
                height: 200,
                width: 300,
                color: Colors.red,
              );
            } else {
              return Center(
                child: Container(
                    color: Colors.green,
                    height: 200,
                    width: 300,
                    child: Text(notes.first.title)),
              );
            }
          },
        )));
  }
}
