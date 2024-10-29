import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/clandarView.dart';
import 'package:wochenplaner_app/widgets/taskListView.dart';

void main() {
  TaskManager taskManager = TaskManager();
  runApp(MyApp(taskManager: taskManager));
}

class MyApp extends StatelessWidget {
  final TaskManager taskManager;
  const MyApp({super.key, required this.taskManager});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wochenplaner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 212, 197, 197), // Set dark background color
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page', taskManager: taskManager),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.taskManager});
  final TaskManager taskManager;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedId = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedId = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: _selectedId == 0
        ? Tasklistview(taskManager: widget.taskManager) 
        : _selectedId == 1
          ? CalendarView(taskManager: widget.taskManager,)
          : Container()
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.list_rounded),
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                _onItemTapped(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
