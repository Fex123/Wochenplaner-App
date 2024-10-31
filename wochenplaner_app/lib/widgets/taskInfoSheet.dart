import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart'; // Ensure this import is correct

class TaskInfoSheet extends StatelessWidget {
  final Task task;
  final TaskManager taskManager;
  final VoidCallback onTaskUpdated;
  final VoidCallback onTaskRemoved;

  const TaskInfoSheet({
    Key? key,
    required this.task,
    required this.taskManager,
    required this.onTaskUpdated,
    required this.onTaskRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                task.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            task.description == ''
                ? 'Diese Task hat keine Beschreibung.'
                : task.description!,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Divider(), // Trennlinie
          if (task.taskDate != null)
            Text(
              'Datum: ${DateFormat.yMMMd().format(task.taskDate!)}',
              style: const TextStyle(fontSize: 16),
            ),
          if (task.startTime != null && task.endTime != null)
            Text(
              'Zeitraum: ${DateFormat.jm().format(task.startTime!)} - ${DateFormat.jm().format(task.endTime!)}',
              style: const TextStyle(fontSize: 16),
            ),
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Task? newTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Createedittask(
                          taskManager: taskManager,
                          taskToEdit: task,
                        ),
                      ),
                    );

                    if (newTask != null) {
                      taskManager.updateTask(newTask);
                      onTaskUpdated(); // Refresh the task list
                    }

                    Navigator.pop(context);
                  },
                  child: const Text('bearbeiten'),
                ),
                const SizedBox(width: 16), // Abstand zwischen den Buttons
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    taskManager.removeTask(task);
                    Navigator.pop(context); // Schließt das Bottom Sheet
                    onTaskRemoved(); // Aktualisiert die Ansicht
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
