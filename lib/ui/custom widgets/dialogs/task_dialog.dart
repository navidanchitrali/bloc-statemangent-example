import 'package:bloc_statemanagment_examples/core/api/notes_api.dart';
import 'package:bloc_statemanagment_examples/core/models/add_task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

typedef OnAddTaskTapped = void Function(
  String email,
  String password,
);

// ignore: must_be_immutable
class TaskDialog extends StatelessWidget {
  TextEditingController titleController;
  TextEditingController desController;
  OnAddTaskTapped onAddTaskTapped;
  String title;
  TaskDialog(
      {Key? key,
      required this.title,
      required this.onAddTaskTapped,
      required this.titleController,
      required this.desController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    NoteApi noteApi = NoteApi();
    // TextEditingController titleController = TextEditingController();
    // TextEditingController desController = TextEditingController();
    return AlertDialog(
      title: const Text('Add Task'),
      content: Container(
        color: Colors.white.withOpacity(0.8),
        height: 320,
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              maxLines: 10,
              controller: desController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            TextButton(
              onPressed: () {
                // await noteApi.addTask(
                //   Task(
                //     id: auth.currentUser!.uid.toString(),
                //     taskTime: DateTime.now().toString(),
                //     taskTitle: titleController.text,
                //     taskDescription: desController.text,
                //   ),
                // );
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
