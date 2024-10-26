import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/createEditTask.dart';

class Tasklistview extends StatelessWidget {
  const Tasklistview({super.key, required this.taskManager});

  final TaskManager taskManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: TaskCardList(cards: [
          TaskCard(), TaskCard(), TaskCard(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Createedittask(taskManager: taskManager);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskCardList extends StatelessWidget {
  final List<TaskCard> cards;

  const TaskCardList({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return cards[index];
      },
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  _TaskCardState createState() => _TaskCardState();
}

//TODO: When Date is empty, remove date card and make radius full

class _TaskCardState extends State<TaskCard> {
  bool isChecked = false;

  // Colors for "unchecked and late", "in Progress", "Checked", "Not started"
  final List<Color> stateColors = [
    const Color.fromARGB(255, 255, 72, 16), // Unchecked and late color
    const Color.fromARGB(255, 236, 184, 10), // In Progress color
    Colors.green,                      // Checked color
    const Color.fromARGB(255, 107, 107, 107) // Not started color
  ];

  // TaskCard Widget made up of 2 separate Cards. Top is Rounded at the Top, Bottom is Rounded at the Bottom.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Card(
            color: isChecked ? stateColors[2] : stateColors[0], // TODO: Once you can check for wether or not the task is late: change color to "In Progress" or "Not Started" depending on State
            margin: const EdgeInsets.only(bottom: 0), 
            shape: const RoundedRectangleBorder(
              borderRadius:  BorderRadius.vertical(
                top: Radius.circular(20),
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
                  const Text(
                    'Task Name',
                    style: TextStyle(
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
                    side: const BorderSide(color: Colors.white, width: 3.0), // White border when unchecked
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 0, bottom: 10), // Zero margin only at the top
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Container(
              width: 300,
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                '22.10 Die 14:00-15:00',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
