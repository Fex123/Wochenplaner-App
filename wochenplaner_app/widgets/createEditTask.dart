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
        body: const Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TaskTextField(labelText: "Enter task name"),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TaskTextField(labelText: "Enter task description"),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: selectDate(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: saveButton(),
              ),
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

  const TaskTextField({Key? key, required this.labelText, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: value);

    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}

class selectDate extends StatefulWidget {
  const selectDate({super.key});

  @override
  State<selectDate> createState() => _selectDateState();
}

class _selectDateState extends State<selectDate> {
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("              "),
              TaskTextField(
                labelText: 'Selected Date',
                value: formattedDate,
              ),
            SizedBox(
              width: 50, // Adjust the width as needed
              child: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class saveButton extends StatefulWidget {
  const saveButton({super.key});

  @override
  State<saveButton> createState() => _saveButtonState();
}

class _saveButtonState extends State<saveButton> {
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