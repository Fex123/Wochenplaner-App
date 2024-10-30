import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';
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
        body: WeekView(
          onEventTap: (events, date) {
            if (events.isNotEmpty) {
              _showTaskDetails(context, events.first);
            }
          },
        ),
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
    return taskManager.getTasks().where((task) {
      return task.taskDate != null && task.startTime != null && task.endTime != null;
    }).map((task) {
      return CalendarEventData(
        date: task.taskDate!,
        title: task.title,
        description: task.description,
        startTime: task.startTime!,
        endTime: task.endTime!,
        color: _getTaskColor(task),
      );
    }).toList();
  }

  Color _getTaskColor(Task task) {
    if (task.isCompleted) {
      return AppColors.checked;
    } else if (isTaskLate(task)) {
      return AppColors.uncheckedLate;
    } else if (isTaskInProgress(task)) {
      return AppColors.inProgress;
    } else {
      return AppColors.notStarted;
    }
  }

  bool isTaskLate(Task task) {
    final now = DateTime.now();
    final taskEndTime = DateTime(
      task.taskDate!.year,
      task.taskDate!.month,
      task.taskDate!.day,
      task.endTime!.hour,
      task.endTime!.minute,
    );
    return now.isAfter(taskEndTime);
  }

  bool isTaskInProgress(Task task) {
    final now = DateTime.now();
    final taskStartTime = DateTime(
      task.taskDate!.year,
      task.taskDate!.month,
      task.taskDate!.day,
      task.startTime!.hour,
      task.startTime!.minute,
    );
    final taskEndTime = DateTime(
      task.taskDate!.year,
      task.taskDate!.month,
      task.taskDate!.day,
      task.endTime!.hour,
      task.endTime!.minute,
    );
    return now.isAfter(taskStartTime) && now.isBefore(taskEndTime);
  }

  void _showTaskDetails(BuildContext context, CalendarEventData event) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity, // Füllt die gesamte Breite des Bildschirms
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                event.description ?? 'No description',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              if (event.date != null)
                Text(
                  'Date: ${DateFormat.yMMMd().format(event.date)}',
                  style: const TextStyle(fontSize: 16),
                ),
              if (event.startTime != null && event.endTime != null)
                Text(
                  'Time: ${DateFormat.jm().format(event.startTime!)} - ${DateFormat.jm().format(event.endTime!)}',
                  style: const TextStyle(fontSize: 16),
                ),
            ],
          ),
        );
      },
    );
  }
}
