import 'package:bloc_statemanagment_examples/core/models/add_task.dart';
import 'package:bloc_statemanagment_examples/core/models/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class NoteApi {
  final _db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///
  /// Add Task to Firestore Database
  ///

  addTask(Task task) async {
    final firebaseDbRef = FirebaseFirestore.instance.collection('Tasks').doc();
    task.docId = firebaseDbRef.id;

    await firebaseDbRef
        .set(task.toJson())
        .then((value) => print('data added successfullyyy'));
  }

  ///
  /// Get all task of current user
  ///
  Future<List<Task>> getCurrentUserTask() async {
    List<Task> allTask = [];
    try {
      final snapshot = await _db
          .collection('Tasks')
          .where("id", isEqualTo: auth.currentUser!.uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (final user in snapshot.docs) {
          allTask.add(Task.fromJson(user.data(), user.id));
        }
      }
    } catch (e, s) {
      debugPrint("DataBaseServices  getCurrentUserTask() Exception: $e}");
      print(s);
    }
    return allTask;
  }

  ///
  /// Remove user task
  ///

  removeTask({required docId}) async {
    try {
      _db.collection('Tasks').doc(docId).delete();
    } catch (e, s) {
      debugPrint("DataBaseServices  removeTask() Exception: $e}");
      print(s);
    }
  }
}
