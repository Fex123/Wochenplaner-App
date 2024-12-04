import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart';
import 'package:wochenplaner_app/widgets/taskInfoSheet.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';

class Tasklistview extends StatefulWidget {
  const Tasklistview({super.key, required this.taskManager});

  final TaskManager taskManager;

  @override
  State<Tasklistview> createState() => _tasklistview();
}

class _tasklistview extends State<Tasklistview> {
  String searchQuery = '';
  String filter = '';

  void _showFilterMenu() async {
    final selectedFilter = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem<String>(
          value: 'no_filter',
          child: Text(
            'No filters',
            style: TextStyle(
              color: filter == 'no_filter'
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'late',
          child: Text(
            'Only late events',
            style: TextStyle(
              color: filter == 'late'
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'unfinished',
          child: Text(
            'Only unfinished events',
            style: TextStyle(
              color: filter == 'unfinished'
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'finished',
          child: Text(
            'Only finished tasks',
            style: TextStyle(
              color: filter == 'finished'
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'ongoing',
          child: Text(
            'Only ongoing tasks',
            style: TextStyle(
              color: filter == 'ongoing'
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
          ),
        ),
      ],
    );

    if (selectedFilter != null) {
      setState(() {
        filter = selectedFilter == 'no_filter' ? '' : selectedFilter;
      });
    }
  }

  void _refreshTaskList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    TaskSearchDelegate(widget.taskManager, _refreshTaskList),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: filter.isNotEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: _showFilterMenu,
          ),
        ],
      ),
      body: Center(
        child: TaskCardList(
          taskManager: widget.taskManager,
          searchQuery: searchQuery,
          filter: filter,
        ),
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
        shape: const CircleBorder(),
      ),
    );
  }
}

class TaskCardList extends StatefulWidget {
  const TaskCardList({
    super.key,
    required this.taskManager,
    required this.searchQuery,
    required this.filter,
  });

  final TaskManager taskManager;
  final String searchQuery;
  final String filter;

  @override
  _TaskCardListState createState() => _TaskCardListState();
}

class _TaskCardListState extends State<TaskCardList> {
  late List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  void didUpdateWidget(TaskCardList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter ||
        oldWidget.searchQuery != widget.searchQuery) {
      _loadTasks();
    }
  }

  Future<void> _loadTasks() async {
    final taskList = await widget.taskManager.getTasks();
    setState(() {
      tasks = taskList;
    });
  }

  Future<void> refreshTasks() async {
    final taskList = await widget.taskManager.getTasks();
    setState(() {
      tasks = taskList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks.where((task) {
      final matchesSearchQuery =
          task.title.toLowerCase().contains(widget.searchQuery.toLowerCase());
      final matchesFilter = widget.filter == 'late'
          ? isTaskLate(task)
          : widget.filter == 'unfinished'
              ? !task.isCompleted
              : widget.filter == 'finished'
                  ? task.isCompleted
                  : widget.filter == 'ongoing'
                      ? isTaskInProgress(task) && !isTaskLate(task)
                      : true;
      return matchesSearchQuery && matchesFilter;
    }).toList();

    return filteredTasks.isEmpty
        ? const Center(child: Text('No tasks available'))
        : ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              return TaskCard(
                task: filteredTasks[index],
                taskManager: widget.taskManager,
                onTaskRemoved: refreshTasks,
                onTaskUpdated: refreshTasks,
              );
            },
          );
  }
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

  if (task.startTime != null && task.startTime!.hour > task.endTime!.hour) {
    final taskEndTimeNextDay = taskEndTime.add(Duration(days: 1));
    return now.isAfter(taskEndTimeNextDay);
  }

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
  var taskEndTime = DateTime(
    task.taskDate!.year,
    task.taskDate!.month,
    task.taskDate!.day,
    task.endTime!.hour,
    task.endTime!.minute,
  );

  if (task.startTime!.hour > task.endTime!.hour ||
      (task.startTime!.hour == task.endTime!.hour &&
          task.startTime!.minute > task.endTime!.minute)) {
    taskEndTime = taskEndTime.add(Duration(days: 1));
  }

  return now.isAfter(taskStartTime) && now.isBefore(taskEndTime);
}

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.taskManager,
    required this.onTaskRemoved,
    required this.onTaskUpdated,
  });

  final Task task;
  final TaskManager taskManager;
  final VoidCallback onTaskRemoved;
  final VoidCallback onTaskUpdated;

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

  @override
  void didUpdateWidget(TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.task.isCompleted != widget.task.isCompleted) {
      setState(() {
        isChecked = widget.task.isCompleted;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return TaskInfoSheet(
            task: widget.task,
            taskManager: widget.taskManager,
            onTaskUpdated: widget.onTaskUpdated,
            onTaskRemoved: widget.onTaskRemoved,
          );
        },
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: isChecked
                  ? AppColors.done
                  : isTaskLate(widget.task)
                      ? AppColors.late.value // Late
                      : isTaskInProgress(widget.task)
                          ? AppColors.inProgress.value // In Progress
                          : AppColors.notStarted, // Not Started
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
                    Expanded(
                      child: Text(
                        widget.task.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isChecked
                              ? AppColors.onDone
                              : isTaskLate(widget.task)
                                  ? AppColors.late.light.onColor // Late
                                  : isTaskInProgress(widget.task)
                                      ? AppColors.inProgress.light
                                          .onColor // In Progress
                                      : AppColors.onNotStarted,
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor:
                              isChecked ? AppColors.onDone : Colors.transparent,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
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
                      checkColor: AppColors.done, // Check mark color
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        // Sets the fill color based on checked state
                        if (states.contains(WidgetState.selected)) {
                          return AppColors.onDone;
                        }
                        return Colors.transparent; // Unchecked state color
                      }),
                      side:
                          const BorderSide(color: AppColors.onDone, width: 3.0),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.task.taskDate != null &&
                widget.task.startTime != null &&
                widget.task.endTime != null)
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TaskSearchDelegate extends SearchDelegate {
  final TaskManager taskManager;
  final VoidCallback onSearchClosed;

  TaskSearchDelegate(this.taskManager, this.onSearchClosed);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
        onSearchClosed();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return TaskCardList(
        taskManager: taskManager, searchQuery: query, filter: '');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return TaskCardList(
        taskManager: taskManager, searchQuery: query, filter: '');
  }
}
