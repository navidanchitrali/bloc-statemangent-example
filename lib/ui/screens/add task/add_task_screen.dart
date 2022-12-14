import 'package:bloc_statemanagment_examples/core/constant/colors.dart';
import 'package:bloc_statemanagment_examples/ui/screens/add%20task/add_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddTaskScreen extends HookWidget {
  final OnAddTaskTapped onAddTaskTapped;
  const AddTaskScreen({Key? key, required this.onAddTaskTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: lightYumColor,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(300)),
            ),
            height: 250,
            child: const Padding(
              padding: EdgeInsets.only(right: 180),
              child: Center(
                child: Text(
                  'Add Task',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: blueFadeColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: lightYumColor),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              maxLines: 5,
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: lightYumColor),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AddTaskButton(
            titleController: titleController,
            descriptionController: descriptionController,
            onAddTaskTapped: onAddTaskTapped,
          ),
        ],
      ),
    );
  }
}
