import '../../data/Task.dart';

class TaskManager {
  List<Task> tasks = [];
  late int countTasks = 0;
  void addTask(Task task) {
    tasks.add(task);
    countTasks++;
  }

  void removeTask(Task task) {
    tasks.remove(task);
  }

  void updateTask(Task task) {
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;
  }

  List<Task> getTasks() {
    return tasks;
  }

  int getCountTasks() {
    return countTasks;
  }
}
