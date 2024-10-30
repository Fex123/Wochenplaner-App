import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';
import '../../data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart';

class Tasklistview extends StatefulWidget {
  const Tasklistview({super.key, required this.taskManager});

  final TaskManager taskManager;

  @override
  State<Tasklistview> createState() => _tasklistview();
}

class _tasklistview extends State<Tasklistview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Liste'),
      ),
      body: Center(
        child: TaskCardList(taskManager: widget.taskManager),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskCardList extends StatefulWidget {
  const TaskCardList({super.key, required this.taskManager});

  final TaskManager taskManager;

  @override
  _TaskCardListState createState() => _TaskCardListState();
}

class _TaskCardListState extends State<TaskCardList> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = widget.taskManager.getTasks();
  }

  void refreshTasks() {
    setState(() {
      tasks = widget.taskManager.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: tasks[index],
          taskManager: widget.taskManager,
          onTaskRemoved: refreshTasks,
          onTaskUpdated: refreshTasks, // Add this callback
        );
      },
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.taskManager,
    required this.onTaskRemoved,
    required this.onTaskUpdated, // Add this parameter
  });

  final Task task;
  final TaskManager taskManager;
  final VoidCallback onTaskRemoved;
  final VoidCallback onTaskUpdated; // Add this parameter

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.task.isCompleted;
  }

  String formatDate() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(widget.task.taskDate!);
  }

  String formatTime(bool isStartTime) {
    final timeFormat =
        MediaQuery.of(context).alwaysUse24HourFormat ? 'HH:mm' : 'hh:mm a';
    final dateFormat = DateFormat(timeFormat);
    if (isStartTime) {
      return dateFormat.format(widget.task.startTime!);
    } else {
      return dateFormat.format(widget.task.endTime!);
    }
  }

  // Colors for "unchecked and late", "in Progress", "Checked", "Not started"
  final List<Color> stateColors = [
    AppColors.uncheckedLate, // Unchecked and late color
    AppColors.inProgress, // In Progress color
    AppColors.checked, // Checked color
    AppColors.notStarted // Not started color
  ];

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
    return now.isAfter(taskEndTime);
  }

  bool isTaskInProgress(Task task) {
    if (task.taskDate == null || task.startTime == null || task.endTime == null)
      return false;
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

  void _showTaskDetails(BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Schließt das Bottom Sheet
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(), // Trennlinie
              Text(
                (widget.task.description == ''
                    ? 'Diese Task hat keine Beschreibung.'
                    : widget.task.description)!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Divider(), // Trennlinie
              if (widget.task.taskDate != null)
                Text(
                  'Datum: ${DateFormat.yMMMd().format(widget.task.taskDate!)}',
                  style: const TextStyle(fontSize: 16),
                ),
              if (widget.task.startTime != null && widget.task.endTime != null)
                Text(
                  'Zeitraum: ${DateFormat.jm().format(widget.task.startTime!)} - ${DateFormat.jm().format(widget.task.endTime!)}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Task? newtask = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Createedittask(
                              taskManager: widget.taskManager,
                              taskToEdit: widget.task,
                            ),
                          ),
                        );

                        if (newtask != null) {
                          setState(() {
                            widget.taskManager.updateTask(newtask);
                            widget.onTaskUpdated(); // Refresh the task list
                          });
                        }

                        Navigator.pop(context);
                      },
                      child: const Text('bearbeiten'),
                    ),
                    const SizedBox(width: 16), // Abstand zwischen den Buttons
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        widget.taskManager.removeTask(widget.task);
                        Navigator.pop(context); // Schließt das Bottom Sheet
                        widget.onTaskRemoved(); // Aktualisiert die Ansicht
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // TaskCard Widget made up of 2 separate Cards. Top is Rounded at the Top, Bottom is Rounded at the Bottom.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _showTaskDetails(context),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                color: isChecked
                    ? stateColors[2]
                    : isTaskLate(widget.task)
                        ? stateColors[0] // Late
                        : isTaskInProgress(widget.task)
                            ? stateColors[1] // In Progress
                            : stateColors[3], // Not Started
                margin: widget.task.taskDate == null ||
                        widget.task.startTime == null ||
                        widget.task.endTime == null
                    ? const EdgeInsets.only(bottom: 10)
                    : const EdgeInsets.only(bottom: 0, top: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(20),
                    bottom: widget.task.taskDate == null ||
                            widget.task.startTime == null ||
                            widget.task.endTime == null
                        ? const Radius.circular(20)
                        : Radius.zero,
                  ),
                ),
                child: Container(
                  width: 300,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.task.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                            widget.task.changeTaskState();
                            widget.taskManager.updateTask(widget.task);
                            widget.onTaskUpdated(); // Refresh the task list
                          });
                        },
                        checkColor: stateColors[2], // Check mark color
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          // Sets the fill color based on checked state
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white; // Checked state color
                          }
                          return Colors.transparent; // Unchecked state color
                        }),
                        side: const BorderSide(
                            color: Colors.white,
                            width: 3.0), // White border when unchecked
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.task.taskDate != null &&
                  widget.task.startTime != null &&
                  widget.task.endTime != null)
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                      top: 0, bottom: 10), // Zero margin only at the top
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: 300,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '${DateFormat.yMMMd().format(widget.task.taskDate!)}\n${formatTime(true)} - ${formatTime(false)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
