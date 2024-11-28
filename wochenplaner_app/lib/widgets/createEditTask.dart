import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wochenplaner_app/data/Task.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';

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
  File? _image; // Add this line

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
      if (widget.taskToEdit!.imagePath != null) {
        _image = File(widget.taskToEdit!.imagePath!);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.taskToEdit != null) {
      if (widget.taskToEdit!.startTime != null) {
        startTimeController.text = _formatTime(widget.taskToEdit!.startTime!);
      }
      if (widget.taskToEdit!.endTime != null) {
        endTimeController.text = _formatTime(widget.taskToEdit!.endTime!);
      }
    }
  }

  String _formatTime(DateTime time) {
    final format = MediaQuery.of(context).alwaysUse24HourFormat
        ? DateFormat('HH:mm')
        : DateFormat('hh:mm a');
    return format.format(time);
  }

  void saveTask() {
    if (taskNameController.text.isEmpty) {
      setState(() {
        errorText = Text('Task name is empty',
            style: TextStyle(color: Theme.of(context).colorScheme.onError));
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
        errorText = Text('Invalid date format. Use yyyy-MM-dd',
            style: TextStyle(color: Theme.of(context).colorScheme.onError));
      });
      return;
    }

    if (selDate != null) {
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      if (selDate.isBefore(today)) {
        setState(() {
          errorText = Text('Selected date is before current date',
              style: TextStyle(color: Theme.of(context).colorScheme.onError));
        });
        return;
      }
    }

    DateTime? startTime;
    try {
      startTime = startTimeController.text.isEmpty
          ? null
          : DateFormat('hh:mm a').parseStrict(startTimeController.text);
    } catch (e) {
      try {
        startTime = startTimeController.text.isEmpty
            ? null
            : DateFormat('HH:mm').parseStrict(startTimeController.text);
      } catch (e) {
        setState(() {
          errorText = Text('Invalid start time format. Use hh:mm a or HH:mm',
              style: TextStyle(color: Theme.of(context).colorScheme.onError));
        });
        return;
      }
    }

    DateTime? endTime;
    try {
      endTime = endTimeController.text.isEmpty
          ? null
          : DateFormat('hh:mm a').parseStrict(endTimeController.text);
    } catch (e) {
      try {
        endTime = endTimeController.text.isEmpty
            ? null
            : DateFormat('HH:mm').parseStrict(endTimeController.text);
      } catch (e) {
        setState(() {
          errorText = Text('Invalid end time format. Use hh:mm a or HH:mm',
              style: TextStyle(color: Theme.of(context).colorScheme.onError));
        });
        return;
      }
    }

    if (startTime != null &&
        endTime != null &&
        !(TimeOfDay.fromDateTime(startTime).period == DayPeriod.pm &&
            TimeOfDay.fromDateTime(startTime).hour == 12 &&
            TimeOfDay.fromDateTime(endTime).period == DayPeriod.am &&
            TimeOfDay.fromDateTime(endTime).hour == 0) &&
        (startTime.hour > endTime.hour ||
            (startTime.hour == endTime.hour &&
                startTime.minute >= endTime.minute) ||
            (endTime.hour == 0 && endTime.minute > 0))) {
      if (endTime.hour != 0 && endTime.minute != 0) {
        setState(() {
          errorText = Text('Start is after or equal to end',
              style: TextStyle(color: Theme.of(context).colorScheme.onError));
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
        startTime: startTime,
        endTime: endTime,
        imagePath: _image?.path, // Add this line
      );} else {
      newTask = Task(
        id: widget.taskManager.getCountTasks().toString(),
        title: taskNameController.text,
        description: taskDescriptionController.text,
        taskDate: selDate,
        startTime: startTime,
        endTime: endTime,
        imagePath: _image?.path, // Add this line
      );
    }

    Navigator.pop(context, newTask);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await showDialog<XFile?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          actions: <Widget>[
            TextButton(
              child: const Text('Camera'),
              onPressed: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.camera);
                Navigator.of(context).pop(pickedFile);
              },
            ),
            TextButton(
              child: const Text('Gallery'),
              onPressed: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context).pop(pickedFile);
              },
            ),
          ],
        );
      },
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create/Edit Task'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0), // Add top margin
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 125 * 2,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      child: _image == null
                          ? const Center(child: Text('Tap to add an image'))
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CancelButton(
                        onPressed: () {
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
        decoration: StaticStyles.appInputDecoration(context, labelText),
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
          const SizedBox(width: 5),
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
      style: StaticStyles.appButtonStyle(context),
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
      style: StaticStyles.appButtonStyle(context),
      onPressed: onPressed,
      child: const Text('Cancel'),
    );
  }
}
