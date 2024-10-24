import 'package:flutter/material.dart';

class Tasklistview extends StatelessWidget {
  const Tasklistview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: TaskListCard()),
    );
  }
}

class TaskListCard extends StatelessWidget {
  const TaskListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 350,  // Set max width of a Card
        ),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color.fromARGB(255, 184, 184, 184), width: 2), // Set the color and thickness of the outline
            borderRadius: BorderRadius.circular(20), // Adjust the radius value to make the border rounder
          ),
          child: _SampleCard(cardName: 'Task name', time: '22.10 Die 11:00-12:00'),
        ),
      ),
    );
  }
}




class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName, required this.time});

  final String cardName;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox( //Korekt positionieren
                  value: false, 
                  onChanged: (bool? newValue) {
                    //Onchange logik einbauen
                  },
                ),
                Text(
                  cardName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Color.fromARGB(255, 184, 184, 184), 
          thickness: 2, 
        ),
        Container(
          width: 300,
          height: 50, 
          alignment: Alignment.center, 
          child: Text(
            time,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
