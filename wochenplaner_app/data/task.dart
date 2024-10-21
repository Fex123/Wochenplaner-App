class Task {

  //obvious attributes
  
  String title;
  String description;
  //To-Do: Add start and end date
  //To-Do: Add options for pictures and memory

  //internal attributes

  int id;
  bool isCompleted;

  Task({
      required this.title,
      required this.description,
      //required this.startDate,
      //required this.endDate,
      required this.id, //To-Do: Automatically declare the id with the list length + 1
      required this.isCompleted,
  });

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