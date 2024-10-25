import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 212, 197, 197), // Set dark background color
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Tasklistview(),
      ),
    );
  }
}
