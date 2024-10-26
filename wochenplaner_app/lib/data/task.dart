import 'package:flutter/material.dart';

class Task {
  //obvious attributes

  String title;
  String? description = '';
  DateTime? taskDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

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
}
