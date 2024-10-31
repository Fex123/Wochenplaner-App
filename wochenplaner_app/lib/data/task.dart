class Task {
  //obvious attributes

  String title;
  String? description = '';
  DateTime? taskDate;
  DateTime? startTime;
  DateTime? endTime;
  String? imagePath; // Add this line

  //To-Do: Add options for pictures and memory

  //internal attributes

  late int id;
  bool isCompleted = false;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.taskDate,
    this.startTime,
    this.endTime,
    this.imagePath, // Add this line
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

  String? getTaskDescription() {
    return description;
  }

  //To-Do: Add a function to set the start and end date/time
  //To-Do: Add a function to set the picture and memory

  Task copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? taskDate,
    DateTime? startTime,
    DateTime? endTime,
    String? imagePath, // Add this line
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskDate: taskDate ?? this.taskDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      imagePath: imagePath ?? this.imagePath, // Add this line
    )..isCompleted = isCompleted ?? this.isCompleted;
  }
}
