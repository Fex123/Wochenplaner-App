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
    await _firestore.collection(userID).doc(task.id).set(task.toMap());
  }

  Future<void> removeTask(Task task) async {
    tasks.remove(task);
    await _firestore.collection(userID).doc(task.id).delete();
  }

  Future<void> updateTask(Task task) async {
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;
    await _firestore.collection(userID).doc(task.id).update(task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final querySnapshot = await _firestore.collection(userID).get();
    tasks = querySnapshot.docs.map((doc) => Task.fromMap(doc.data())).toList();
    countTasks = tasks.length;
    return tasks;
  }

  int getCountTasks() {
    return countTasks;
  }

  void deleteCollection () async {
    final querySnapshot = await _firestore.collection(userID).get();
    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
