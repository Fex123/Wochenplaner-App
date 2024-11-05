import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart';
import 'package:wochenplaner_app/widgets/taskInfoSheet.dart';

class CalendarView extends StatefulWidget {
  final TaskManager taskManager;
  final Settings settings;

  const CalendarView(
      {super.key, required this.taskManager, required this.settings});

  @override
  State<CalendarView> createState() => _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  int _selectedViewIndex = 1;

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController()
        ..addAll(_convertTasksToEvents(widget.taskManager)),
      child: Scaffold(
        appBar: AppBar(
          title: StaticComponents.staticAppBar('Calendar'),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            _buildSegmentedControl(),
            Expanded(
              child: _buildCalendarView(widget.settings),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Task? newtask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Createedittask(
                  taskManager: widget.taskManager,
                ),
              ),
            );
            if (newtask != null) {
              setState(() {
                widget.taskManager.addTask(newtask);
              });
            }
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SegmentedButton(
        segments: const [
          ButtonSegment(value: 0, label: Text('Day')),
          ButtonSegment(value: 1, label: Text('Week')),
          ButtonSegment(value: 2, label: Text('Month')),
        ],
        selected: {_selectedViewIndex},
        onSelectionChanged: (Set<int> newSelection) {
          setState(() {
            _selectedViewIndex = newSelection.first;
          });
        },
      ),
    );
  }

  final HeaderStyle _headerStyle = const HeaderStyle(
      decoration: BoxDecoration(
    color: Colors.white,
  ));

  Widget _buildCalendarView(Settings settings) {
    switch (_selectedViewIndex) {
      case 0:
        return DayView(
            startHour: settings.getStartHour(),
            endHour: settings.getEndHour(),
            onEventTap: (events, date) {
              if (events.isNotEmpty) {
                Task task = _getTaskFromEvent(events.first);
                _showTaskInfoSheet(context, task);
              }
            },
            headerStyle: _headerStyle);
      case 1:
        return WeekView(
            startHour: settings.getStartHour(),
            endHour: settings.getEndHour(),
            onEventTap: (events, date) {
              if (events.isNotEmpty) {
                Task task = _getTaskFromEvent(events.first);
                _showTaskInfoSheet(context, task);
              }
            },
            headerStyle: _headerStyle);
      case 2:
        return MonthView(
            onEventTap: (events, date) {
              Task task = _getTaskFromEvent(events);
              _showTaskInfoSheet(context, task);
            },
            headerStyle: _headerStyle);
      default:
        return Container();
    }
  }

  List<CalendarEventData> _convertTasksToEvents(TaskManager taskManager) {
    return taskManager.getTasks().where((task) {
      return task.taskDate != null &&
          task.startTime != null &&
          task.endTime != null;
    }).map((task) {
      final eventData = CalendarEventData(
        date: task.taskDate!,
        title: task.title,
        description: task.description,
        startTime: task.startTime!,
        endTime: task.endTime!,
        color: (task.isCompleted
            ? AppColors.done
            : (isTaskLate(task)
                ? AppColors.late.value
                : (isTaskInProgress(task)
                    ? AppColors.inProgress.value
                    : AppColors.notStarted))),
        titleStyle: TextStyle(
            fontSize: 15,
            color: (task.isCompleted
                ? Colors.white
                : (isTaskLate(task)
                    ? AppColors.late.light.onColor
                    : (isTaskInProgress(task)
                        ? AppColors.inProgress.light.onColor
                        : Colors.white)))),
        descriptionStyle: const TextStyle(fontSize: 13),
      );
      task.eventData = eventData; // Store the event data in the task
      return eventData;
    }).toList();
  }

  Task _getTaskFromEvent(CalendarEventData event) {
    return widget.taskManager
        .getTasks()
        .firstWhere((task) => task.eventData == event);
  }

  bool isTaskLate(Task task) {
    if (task.taskDate == null || task.endTime == null) return false;

    final now = DateTime.now();
    final taskEndTime = DateTime(
      task.taskDate!.year,
      task.taskDate!.month,
      task.taskDate!.day,
      task.endTime!.hour,
      task.endTime!.minute,
    );

    // Check if the task spans across midnight
    if (task.startTime != null && task.startTime!.hour > task.endTime!.hour) {
      // If the current time is before the task end time on the next day
      final taskEndTimeNextDay = taskEndTime.add(const Duration(days: 1));
      return now.isAfter(taskEndTimeNextDay);
    }

    return now.isAfter(taskEndTime);
  }

  bool isTaskInProgress(Task task) {
    if (task.taskDate == null ||
        task.startTime == null ||
        task.endTime == null) {
      return false;
    }

    final now = DateTime.now();
    final taskStartTime = DateTime(
      task.taskDate!.year,
      task.taskDate!.month,
      task.taskDate!.day,
      task.startTime!.hour,
      task.startTime!.minute,
    );
    var taskEndTime = DateTime(
      task.taskDate!.year,
      task.taskDate!.month,
      task.taskDate!.day,
      task.endTime!.hour,
      task.endTime!.minute,
    );

    // Check if the task spans across midnight
    if (task.startTime!.hour > task.endTime!.hour ||
        (task.startTime!.hour == task.endTime!.hour &&
            task.startTime!.minute > task.endTime!.minute)) {
      taskEndTime = taskEndTime.add(const Duration(days: 1));
    }

    return now.isAfter(taskStartTime) && now.isBefore(taskEndTime);
  }

  void _showTaskInfoSheet(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TaskInfoSheet(
          taskManager: widget.taskManager,
          task: task,
          onTaskRemoved: () => {
            setState(() {
              // Just refresh the view
            })
          },
          onTaskUpdated: () => {
            setState(() {
              // Just refresh the view
            })
          },
        );
      },
    );
  }
}
