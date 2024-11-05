import 'package:cloud_firestore/cloud_firestore.dart';
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
    await _firestore.collection('task').doc(userID).set({
      'tasks': tasks.map((task) => task.toMap()).toList(),
    });
  }

  Future<void> removeTask(Task task) async {
    tasks.remove(task);
    await _firestore.collection('task').doc(userID).set({
      'tasks': tasks.map((task) => task.toMap()).toList(),
    });
  }

  Future<void> updateTask(Task task) async {
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;
    await _firestore.collection('task').doc(userID).set({
      'tasks': tasks.map((task) => task.toMap()).toList(),
    });
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
