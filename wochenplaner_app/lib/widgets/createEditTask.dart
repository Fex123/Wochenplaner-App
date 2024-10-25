import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Createedittask extends StatefulWidget{
  const Createedittask({super.key});
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

  void saveTask() {
    if (taskNameController.text.isEmpty) {
      print("Task name is empty");
      return;
    }

    DateTime? selDate;
    try {
      selDate = selectedDateController.text.isEmpty
          ? null
          : DateFormat('yyyy-MM-dd').parseStrict(selectedDateController.text);
    } catch (e) {
      print("Invalid date format. Use yyyy-MM-dd");
      return;
    }

    if (selDate != null) {
      if (selDate.isBefore(DateTime.now())) {
        print("Selected date is before current date");
        return;
      }
    }

     TimeOfDay? startTime;
  try {
    startTime = startTimeController.text.isEmpty
        ? null
        : TimeOfDay.fromDateTime(
            DateFormat('hh:mm a').parseStrict(startTimeController.text));
  } catch (e) {
    print("Invalid start time format. Use hh:mm a");
    return;
  }

  TimeOfDay? endTime;
  try {
    endTime = endTimeController.text.isEmpty
        ? null
        : TimeOfDay.fromDateTime(
            DateFormat('hh:mm a').parseStrict(endTimeController.text));
  } catch (e) {
    print("Invalid end time format. Use hh:mm a");
    return;
  }
  
  if (startTime != null && endTime != null &&
      (startTime.hour >= endTime.hour ||
      (startTime.hour == endTime.hour && startTime.minute >= endTime.minute))) {
        print("Start time is after or equal to end time");
        return;
      }

    // Save the task
    print('Task Name: ${taskNameController.text}');
  print('Task Description: ${taskDescriptionController.text}');
  print('Date: $selDate');
  print('Start Time: ${startTime != null ? '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}' : ''}');
  print('End Time: ${endTime != null ? '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}' : ''}');
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    maxInputLength: 100,
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
                  child: SaveButton(saveTask: saveTask),
                ),
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
  final double widthMultiplyer;
  final TextEditingController controller;
  final int? maxInputLength;

  const TaskTextField({
    super.key,
    required this.labelText,
    required this.widthMultiplyer,
    required this.controller,
    this.maxInputLength,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125 * widthMultiplyer,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        maxLength: maxInputLength,
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
          widget.startTimeController.text = _startTime!.format(context);
        } else {
          _endTime = picked;
          widget.endTimeController.text = _endTime!.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedStartTime =
        _startTime != null ? _startTime!.format(context) : '';
    final String formattedEndTime =
        _endTime != null ? _endTime!.format(context) : '';

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              TaskTextField(
                labelText: 'Start',
                widthMultiplyer: 1,
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
                widthMultiplyer: 1,
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
