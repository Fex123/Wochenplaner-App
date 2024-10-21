import 'Task.dart';

class TaskManager{
  List<Task> tasks = [];
  void addTask(Task task){
    tasks.add(task);
  }
  void removeTask(Task task){
    tasks.remove(task);
  }
  void updateTask(Task task){
    tasks[tasks.indexWhere((element) => element.id == task.id)] = task;
  }
}