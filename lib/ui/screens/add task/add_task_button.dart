import 'package:bloc_statemanagment_examples/core/constant/colors.dart';
import 'package:bloc_statemanagment_examples/ui/custom%20widgets/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

typedef OnAddTaskTapped = void Function(
  String taskTitle,
  String taskDescription,
);

class AddTaskButton extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final OnAddTaskTapped onAddTaskTapped;
  const AddTaskButton({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.onAddTaskTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: lightYumColor),
      onPressed: () {
        final title = titleController.text;
        final description = descriptionController.text;
        if (title.isEmpty || description.isEmpty) {
          showGenericDialog<bool>(
            context: context,
            title: 'Title and Description should no be empty',
            content: 'Please enter both the title and description',
            optionBuilder: () => {'ok': true},
          );
        } else {
          onAddTaskTapped(
            title,
            description,
          );
        }
      },
      child: const Text(
        'Add',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
