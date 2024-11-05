import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/data/userManagement.dart';
import 'package:wochenplaner_app/widgets/clandarView.dart';
import 'package:wochenplaner_app/widgets/settingsView.dart';
import 'package:wochenplaner_app/widgets/taskListView.dart';
import 'package:wochenplaner_app/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  MaterialTheme mainTheme = const MaterialTheme(Typography.blackCupertino);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wochenplaner',
      theme: mainTheme.light(),
      /* ThemeData(
        brightness: Brightness.light, // Helles Thema
        primarySwatch: Colors.blue,
        colorScheme: MaterialTheme.lightScheme().toColorScheme(),
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 212, 197, 197), // Set dark background color
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),*/
      darkTheme: mainTheme.dark(),
      /*ThemeData(
        brightness: Brightness.dark, // Dunkles Thema
        primarySwatch: Colors.blue,
      ),*/
      themeMode: _themeMode,
      home: LoginScreen(taskManager: widget.taskManager, settings: widget.settings,toggleThemeMode: toggleThemeMode,) //MyHomePage(taskManager: widget.taskManager, toggleThemeMode: toggleThemeMode, settings: widget.settings,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.taskManager, required this.toggleThemeMode, required this.settings});
  final VoidCallback toggleThemeMode;
  final TaskManager taskManager;
  final Settings settings;

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
      body: Center(
        child: _selectedId == 0
            ? Tasklistview(taskManager: widget.taskManager)
            : _selectedId == 1
                ? CalendarView(
                    taskManager: widget.taskManager,
                    settings: widget.settings,
                  )
                : _selectedId == 2
                    ? SettingsView(
                        toggleThemeMode: widget.toggleThemeMode,
                        settings: widget.settings,
                      )
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
