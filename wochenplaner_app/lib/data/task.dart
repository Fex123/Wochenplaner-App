import 'package:calendar_view/calendar_view.dart';

class Task {

  String title;
  String? description = '';
  DateTime? taskDate;
  DateTime? startTime;
  DateTime? endTime;
  String? image;
  CalendarEventData? eventData;

  late String id;
  bool isCompleted = false;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.taskDate,
    this.startTime,
    this.endTime,
    this.image,
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

  void setEvent(CalendarEventData event) {
    eventData = event;
  }

  //To-Do: Add a function to set the start and end date/time
  //To-Do: Add a function to set the picture and memory

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? taskDate,
    DateTime? startTime,
    DateTime? endTime,
    String? image,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      taskDate: taskDate ?? this.taskDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      image: image ?? this.image,
    )..isCompleted = isCompleted ?? this.isCompleted;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'taskDate': taskDate?.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'image': image,
      'isCompleted': isCompleted,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      taskDate: map['taskDate'] != null ? DateTime.parse(map['taskDate']) : null,
      startTime: map['startTime'] != null ? DateTime.parse(map['startTime']) : null,
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
      image: map['image'],
    )..isCompleted = map['isCompleted'] ?? false;
  }
}
