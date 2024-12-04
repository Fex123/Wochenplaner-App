import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/Task.dart';

class TaskManager {
  List<Task> tasks = [];
  late int countTasks = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userID;

  TaskManager(this.userID);

  Future<void> addTask(Task task) async {
    tasks.add(task);
    countTasks++;
    try {
      final taskMap = task.toMap();
      print('Task to be added: $taskMap');
      await _firestore.collection('task').doc(userID).set({
        'tasks': tasks.map((task) => task.toMap()).toList(),
      });
      print('Task added successfully');
    } catch (e) {
      print('Failed to add task: $e');
    }
  }

  Future<bool> removeTask(BuildContext context, Task task) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm) {
      tasks.remove(task);
      await _firestore.collection('task').doc(userID).set({
        'tasks': tasks.map((task) => task.toMap()).toList(),
      });
    }
    return confirm;
  }

  Future<void> updateTask(Task task) async {
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;
    try {
      final taskMap = task.toMap();
      print('Task to be updated: $taskMap');
      await _firestore.collection('task').doc(userID).set({
        'tasks': tasks.map((task) => task.toMap()).toList(),
      });
      print('Task updated successfully');
    } catch (e) {
      print('Failed to update task: $e');
    }
  }

  Future<List<Task>> getTasks() async {
    final docSnapshot = await _firestore.collection('task').doc(userID).get();
    if (docSnapshot.exists) {
      tasks = (docSnapshot.data()?['tasks'] as List)
          .map((taskData) => Task.fromMap(taskData))
          .toList();
      countTasks = tasks.length;
    }
    return tasks;
  }

  int getCountTasks() {
    return countTasks;
  }

  void deleteCollection() async {
    await _firestore.collection('task').doc(userID).delete();
  }
}
