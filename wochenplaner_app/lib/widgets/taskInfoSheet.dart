import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart'; // Ensure this import is correct
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskInfoSheet extends StatelessWidget {
  final Task task;
  final TaskManager taskManager;
  final VoidCallback onTaskUpdated;
  final VoidCallback onTaskRemoved;

  const TaskInfoSheet({
    super.key,
    required this.task,
    required this.taskManager,
    required this.onTaskUpdated,
    required this.onTaskRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // Close the Bottom Sheet
                      },
                    ),
                  ],
                ),
                const Divider(), // Trennlinie
                const SizedBox(height: 8),
                if (task.description != null &&
                    task.description!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      task.description!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(), // Divider under the description
                ],
                if (task.taskDate != null)
                  Text(
                    '${AppLocalizations.of(context)?.date ?? 'Date:'} ${DateFormat.yMMMd().format(task.taskDate!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                if (task.startTime != null && task.endTime != null) ...[
                  Text(
                    '${AppLocalizations.of(context)?.time_period ?? 'Time period:'} ${DateFormat.jm().format(task.startTime!)} - ${DateFormat.jm().format(task.endTime!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(), // Divider under the time
                ],
                if (task.image != null) ...[
                  const Divider(), // Trennlinie
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(
                            base64Decode(task.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
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
                        },
                        child:
                            Text(AppLocalizations.of(context)?.edit ?? 'Edit'),
                      ),
                      const SizedBox(width: 16), // Abstand zwischen den Buttons
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          bool confirm =
                              await taskManager.removeTask(context, task);
                          if (confirm) {
                            Navigator.pop(context); // Schließt das Bottom Sheet
                            onTaskRemoved(); // Aktualisiert die Ansicht
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
