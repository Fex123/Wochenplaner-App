import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Createedittask extends StatelessWidget{
  const Createedittask({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create/Edit Task'),
        ),
        body: const SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TaskTextField(
                      labelText: "Enter task name", widthMultiplyer: 2),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TaskTextField(
                      labelText: "Enter task description", widthMultiplyer: 2),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SelectDate(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SelectTime(),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SaveButton(),
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

  const TaskTextField(
      {super.key,
      required this.labelText,
      required this.widthMultiplyer,
      this.value});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);

    return SizedBox(
      width: 125 * widthMultiplyer,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _selectDateState();
}

class _selectDateState extends State<SelectDate> {
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = _selectedDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
        : '';

    return Center(
      child: Stack(
        children: <Widget>[
          TaskTextField(
            labelText: 'Selected Date',
            widthMultiplyer: 2,
            value: formattedDate,
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
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _selectTimeState();
}

class _selectTimeState extends State<SelectTime> {
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
        } else {
          _endTime = picked;
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
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _saveButtonState();
}

class _saveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Save action
      },
      child: const Text('Save'),
    );
  }
}
