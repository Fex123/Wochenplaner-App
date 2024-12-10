import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart';
import 'package:wochenplaner_app/widgets/taskInfoSheet.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return FutureBuilder<List<CalendarEventData>>(
      future: _convertTasksToEvents(widget.taskManager),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(AppLocalizations.of(context)?.error_loading_events ??
                  'Error loading events'));
        } else {
          return Scaffold(
              appBar: StaticComponents.staticAppBar(
                  AppLocalizations.of(context)?.calendar ?? 'Calendar',
                  context),
              body: CalendarControllerProvider(
                controller: EventController()..addAll(snapshot.data!),
                child: Scaffold(
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
              ));
        }
      },
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SegmentedButton(
        segments: [
          ButtonSegment(
              value: 0,
              label: Text(AppLocalizations.of(context)?.day ?? 'Day')),
          ButtonSegment(
              value: 1,
              label: Text(AppLocalizations.of(context)?.week ?? 'Week')),
          ButtonSegment(
              value: 2,
              label: Text(AppLocalizations.of(context)?.month ?? 'Month')),
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

  Widget _buildCalendarView(Settings settings) {
    final HeaderStyle headerStyle = HeaderStyle(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        rightIconConfig: IconDataConfig(
          color: Theme.of(context).colorScheme.onSurface,
          size: 30,
        ),
        leftIconConfig: IconDataConfig(
          color: Theme.of(context).colorScheme.onSurface,
          size: 30,
        ));

    switch (_selectedViewIndex) {
      case 0:
        return DayView(
            backgroundColor: Theme.of(context).colorScheme.surface,
            startHour: settings.getStartHour(),
            endHour: settings.getEndHour(),
            showHalfHours: settings.selectedHalfHourLines,
            onDateTap: (date) async {
              Task? newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Createedittask(
                    taskManager: widget.taskManager,
                    taskToEdit: Task(
                      id: widget.taskManager.getCountTasks().toString(),
                      title: '',
                      taskDate: date,
                      startTime: date,
                    ),
                  ),
                ),
              );
              if (newTask != null) {
                setState(() {
                  widget.taskManager.addTask(newTask);
                });
              }
            },
            onEventTap: (events, date) async {
              if (events.isNotEmpty) {
                Task? task = await _getTaskFromEvent(events.first);
                if (task != null) {
                  _showTaskInfoSheet(context, task);
                }
              }
            },
            headerStyle: headerStyle);
      case 1:
        return WeekView(
          heightPerMinute: 1,
          backgroundColor: Theme.of(context).colorScheme.surface,
          startHour: settings.getStartHour(),
          endHour: settings.getEndHour(),
          showHalfHours: settings.selectedHalfHourLines,
          onDateTap: (date) async {
            Task? newTask = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Createedittask(
                  taskManager: widget.taskManager,
                  taskToEdit: Task(
                    id: widget.taskManager.getCountTasks().toString(),
                    title: '',
                    taskDate: date,
                    startTime: date,
                  ),
                ),
              ),
            );
            if (newTask != null) {
              setState(() {
                widget.taskManager.addTask(newTask);
              });
            }
          },
          onEventTap: (events, date) async {
            if (events.isNotEmpty) {
              Task? task = await _getTaskFromEvent(events.first);
              if (task != null) {
                _showTaskInfoSheet(context, task);
              }
            }
          },

          // This Code-Snippet can
          headerStyle: headerStyle,
          headerStringBuilder: (date, {secondaryDate}) {
            return '${DateFormat('dd.MM.yyyy').format(date)}     -     ${DateFormat('dd.MM.yyyy').format(secondaryDate!)}';
          },
        );
      case 2:
        return MonthView(
            onCellTap: (date, events) async {
              Task? newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Createedittask(
                    taskManager: widget.taskManager,
                    taskToEdit: Task(
                      id: widget.taskManager.getCountTasks().toString(),
                      title: '',
                      taskDate: events,
                    ),
                  ),
                ),
              );
              if (newTask != null) {
                setState(() {
                  widget.taskManager.addTask(newTask);
                });
              }
            },
            onEventTap: (events, date) async {
              Task? task = await _getTaskFromEvent(events);
              if (task != null) {
                _showTaskInfoSheet(context, task);
              }
            },
            headerStyle: headerStyle);
      default:
        return Container();
    }
  }

  Future<List<CalendarEventData>> _convertTasksToEvents(
      TaskManager taskManager) async {
    final tasks = await taskManager.getTasks();
    return tasks.where((task) {
      return task.taskDate != null &&
          task.startTime != null &&
          task.endTime != null;
    }).map((task) {
      final eventData = CalendarEventData(
        date: task.taskDate!,
        title: task.title,
        description:
            "${task.description ?? ''}\n[ID:${task.id}]", // Add ID to description
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
            fontSize: 10,
            color: (task.isCompleted
                ? AppColors.onDone
                : (isTaskLate(task)
                    ? AppColors.late.light.onColor
                    : (isTaskInProgress(task)
                        ? AppColors.inProgress.light.onColor
                        : AppColors.onNotStarted)))),
        descriptionStyle: const TextStyle(fontSize: 13),
      );
      task.eventData = eventData; // Store the event data in the task
      return eventData;
    }).toList();
  }

  Future<Task?> _getTaskFromEvent(CalendarEventData event) async {
    final tasks = await widget.taskManager.getTasks();
    final idMatch = RegExp(r'\[ID:(.*?)\]').firstMatch(event.description ?? '');
    if (idMatch != null) {
      final taskId = idMatch.group(1);
      for (var task in tasks) {
        if (task.id == taskId) {
          return task;
        }
      }
    }
    return null;
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
