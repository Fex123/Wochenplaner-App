import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart';

class CalendarView extends StatefulWidget {
  final TaskManager taskManager;

  const CalendarView({super.key, required this.taskManager});

  @override
  State<CalendarView> createState() => _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController()
        ..addAll(_convertTasksToEvents(widget.taskManager)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kalenderansicht'),
        ),
        body: 
        const WeekView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Task newtask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Createedittask(
                  taskManager: widget.taskManager,
                ),
              ),
            );
            setState(() {
              widget.taskManager.addTask(newtask);
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  List<CalendarEventData> _convertTasksToEvents(TaskManager taskManager) {
    return taskManager.getTasks().map((task) {
      return CalendarEventData(
        date: task.taskDate!,
        title: task.title,
        description: task.description,
        startTime: task.startTime,
        endTime: task.endTime,
      );
    }).toList();
  }
}
