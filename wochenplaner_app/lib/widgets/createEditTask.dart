import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';

class Createedittask extends StatefulWidget {
  final TaskManager taskManager;
  final Task? taskToEdit;

  const Createedittask({super.key, required this.taskManager, this.taskToEdit});
  @override
  State<Createedittask> createState() => _CreateedittaskState();
}

class _CreateedittaskState extends State<Createedittask> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController selectedDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  Text errorText = const Text('');

  @override
  void initState() {
    super.initState();
    if (widget.taskToEdit != null) {
      taskNameController.text = widget.taskToEdit!.title;
      taskDescriptionController.text = widget.taskToEdit!.description ?? '';
      if (widget.taskToEdit!.taskDate != null) {
        selectedDateController.text =
            DateFormat('yyyy-MM-dd').format(widget.taskToEdit!.taskDate!);
      }
      if (widget.taskToEdit!.startTime != null) {
        startTimeController.text =
            DateFormat.jm().format(widget.taskToEdit!.startTime!);
      }
      if (widget.taskToEdit!.endTime != null) {
        endTimeController.text =
            DateFormat.jm().format(widget.taskToEdit!.endTime!);
      }
    }
  }

  void saveTask() {
    if (taskNameController.text.isEmpty) {
      setState(() {
        errorText = const Text('Task name is empty',
            style: TextStyle(color: Colors.red));
      });
      return;
    }

    DateTime? selDate;
    try {
      selDate = selectedDateController.text.isEmpty
          ? null
          : DateFormat('yyyy-MM-dd').parseStrict(selectedDateController.text);
    } catch (e) {
      setState(() {
        errorText = const Text('Invalid date format. Use yyyy-MM-dd',
            style: TextStyle(color: Colors.red));
      });
      return;
    }

    if (selDate != null) {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      if (selDate.isBefore(today)) {
        setState(() {
          errorText = const Text('Selected date is before current date',
              style: TextStyle(color: Colors.red));
        });
        return;
      }
    }

    DateTime? _startTime;
    try {
      _startTime = startTimeController.text.isEmpty
          ? null
          : DateFormat('hh:mm a').parseStrict(startTimeController.text);
    } catch (e) {
      try {
        _startTime = startTimeController.text.isEmpty
            ? null
            : DateFormat('HH:mm').parseStrict(startTimeController.text);
      } catch (e) {
        setState(() {
          errorText = const Text(
              'Invalid start time format. Use hh:mm a or HH:mm',
              style: TextStyle(color: Colors.red));
        });
        return;
      }
    }

    DateTime? _endTime;
    try {
      _endTime = endTimeController.text.isEmpty
          ? null
          : DateFormat('hh:mm a').parseStrict(endTimeController.text);
    } catch (e) {
      try {
        _endTime = endTimeController.text.isEmpty
            ? null
            : DateFormat('HH:mm').parseStrict(endTimeController.text);
      } catch (e) {
        setState(() {
          errorText = const Text(
              'Invalid end time format. Use hh:mm a or HH:mm',
              style: TextStyle(color: Colors.red));
        });
        return;
      }
    }

    if (_startTime != null &&
        _endTime != null &&
        !(TimeOfDay.fromDateTime(_startTime).period == DayPeriod.pm &&
          TimeOfDay.fromDateTime(_startTime).hour == 12 &&
          TimeOfDay.fromDateTime(_endTime).period == DayPeriod.am &&
          TimeOfDay.fromDateTime(_endTime).hour == 0) &&
        (_startTime.hour > _endTime.hour ||
            (_startTime.hour == _endTime.hour &&
                _startTime.minute >= _endTime.minute) ||
            (_endTime.hour == 0 && _endTime.minute > 0))) {
      if (_endTime.hour != 0 && _endTime.minute != 0) {
        setState(() {
          errorText = const Text('Start is after or equal to end',
              style: TextStyle(color: Colors.red));
        });
        return;
      }
    }

    Task newTask;
    if (widget.taskToEdit != null) {
      newTask = widget.taskToEdit!.copyWith(
        title: taskNameController.text,
        description: taskDescriptionController.text,
        taskDate: selDate,
        startTime: _startTime,
        endTime: _endTime,
      );
    } else {
      newTask = Task(
        id: widget.taskManager.getCountTasks(),
        title: taskNameController.text,
        description: taskDescriptionController.text,
        taskDate: selDate,
        startTime: _startTime,
        endTime: _endTime,
      );
    }

    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create/Edit Task'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TaskTextField(
                    labelText: "Enter task name",
                    widthMultiplyer: 2,
                    controller: taskNameController,
                    maxInputLength: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TaskTextField(
                    labelText: "Enter task description",
                    widthMultiplyer: 2,
                    controller: taskDescriptionController,
                    maxInputLength: 120,
                    lines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectDate(
                    controller: selectedDateController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectTime(
                    startTimeController: startTimeController,
                    endTimeController: endTimeController,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CancelButton(
                        onPressed: () {
                          //TODO: WHen pressing Cancel in edit mode, it pauses here
                          Navigator.pop(context, null);
                        },
                      ),
                      const SizedBox(width: 16), // Abstand zwischen den Buttons
                      SaveButton(saveTask: saveTask),
                    ],
                  ),
                ),
                errorText,
              ],
            ),
          ),
        ),
      );
  }
}

class TaskTextField extends StatelessWidget {
  final String labelText;
  final String? value;
  final double? widthMultiplyer;
  final TextEditingController controller;
  final int? lines;
  final int? maxInputLength;


  const TaskTextField({
    super.key,
    required this.labelText,
    this.widthMultiplyer,
    required this.controller,
    this.lines = 1,
    this.maxInputLength,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125 * (widthMultiplyer ?? 1),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        maxLength: maxInputLength,
        maxLines: lines,
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  final TextEditingController controller;

  const SelectDate({super.key, required this.controller});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          TaskTextField(
            labelText: 'Selected Date',
            widthMultiplyer: 2,
            controller: widget.controller,
          ),
          Positioned(
            right: 0,
            top: 5,
            child: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;

  const SelectTime({
    super.key,
    required this.startTimeController,
    required this.endTimeController,
  });

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          widget.startTimeController.text = _formatTime(_startTime!);
        } else {
          _endTime = picked;
          widget.endTimeController.text = _formatTime(_endTime!);
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = MediaQuery.of(context).alwaysUse24HourFormat
        ? DateFormat('HH:mm')
        : DateFormat('hh:mm a');
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final String formattedStartTime =
        _startTime != null ? _formatTime(_startTime!) : '';
    final String formattedEndTime =
        _endTime != null ? _formatTime(_endTime!) : '';

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              TaskTextField(
                labelText: 'Start',
                value: formattedStartTime,
                controller: widget.startTimeController,
              ),
              Positioned(
                right: 0,
                top: 5,
                child: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context, true),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              TaskTextField(
                labelText: 'End',
                value: formattedEndTime,
                controller: widget.endTimeController,
              ),
              Positioned(
                right: 0,
                top: 5,
                child: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context, false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SaveButton extends StatefulWidget {
  final Function saveTask;
  const SaveButton({super.key, required this.saveTask});

  @override
  State<SaveButton> createState() => _saveButtonState();
}

class _saveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.saveTask();
      },
      child: const Text('Save'),
    );
  }
}

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CancelButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Cancel'),
    );
  }
}
