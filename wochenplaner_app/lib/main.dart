import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/widgets/clandarView.dart';
import 'package:wochenplaner_app/widgets/settingsView.dart';
import 'package:wochenplaner_app/widgets/taskListView.dart';

void main() {
  TaskManager taskManager = TaskManager();
  Settings settings = Settings();
  runApp(MyApp(taskManager: taskManager, settings: settings));
}

class MyApp extends StatefulWidget {
  final TaskManager taskManager;
  final Settings settings;
  const MyApp({super.key, required this.taskManager, required this.settings});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleThemeMode (){
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wochenplaner',
      theme: ThemeData(
        brightness: Brightness.light, // Helles Thema
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 212, 197, 197), // Set dark background color
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dunkles Thema
        primarySwatch: Colors.blue,
      ),
      themeMode: _themeMode,
      home: MyHomePage(title: 'Flutter Demo Home Page', taskManager: widget.taskManager, toggleThemeMode: toggleThemeMode, settings: widget.settings,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.taskManager, required this.toggleThemeMode, required this.settings});
  final VoidCallback toggleThemeMode;
  final TaskManager taskManager;
  final Settings settings;
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
          ? CalendarView(taskManager: widget.taskManager,settings: widget.settings,)
          : _selectedId == 2
            ? SettingsView(toggleThemeMode: widget.toggleThemeMode,settings: widget.settings,)
            : Container(),
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
            IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _onItemTapped(2);
            },
            ),
          ],
        ),
      ),
    );
  }
}
