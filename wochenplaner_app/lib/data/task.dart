import 'taskStorage.dart';

class Task {

  //obvious attributes
  
  String title;
  String description;
  //To-Do: Add start and end date
  //To-Do: Add options for pictures and memory

  //internal attributes

  late int id;
  bool isCompleted;

  Task({
      required this.title,
      required this.description,
      //required this.startDate,
      //required this.endDate,
      required this.isCompleted,
  }) {
    id = TaskManager().tasks.length;
  }

  void changeTaskState() {
    isCompleted = !isCompleted;
  }

  bool getTaskState() {
    return isCompleted;
  }

  void changeTaskTitle(String newTitle) {
    title = newTitle;
  }

  String getTaskTitle() {
    return title;
  }

  void changeTaskDescription(String newDescription) {
    description = newDescription;
  }

  String getTaskDescription() {
    return description;
  }

  //To-Do: Add a function to set the start and end date
  //To-Do: Add a function to set the picture and memory
}