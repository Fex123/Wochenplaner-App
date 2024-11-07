import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/data/userManagement.dart';
import 'package:wochenplaner_app/widgets/clandarView.dart';
import 'package:wochenplaner_app/widgets/settingsView.dart';
import 'package:wochenplaner_app/widgets/taskListView.dart';
import 'package:wochenplaner_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Settings settings = Settings();
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(settings: settings, isLoggedIn: user != null));
}

class MyApp extends StatefulWidget {
  final Settings settings;
  final bool isLoggedIn;
  const MyApp({super.key, required this.settings, required this.isLoggedIn});

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

  final TextTheme textTheme = GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme,
  );

  late MaterialTheme mainTheme;

  @override
  Widget build(BuildContext context) {
    mainTheme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Wochenplaner',
      theme: mainTheme.light(),
      darkTheme: mainTheme.dark(),
      themeMode: _themeMode,
      home: widget.isLoggedIn
          ? MyHomePage(
              taskManager: TaskManager(FirebaseAuth.instance.currentUser!.uid),
              toggleThemeMode: toggleThemeMode,
              settings: widget.settings,
            )
          : LoginScreen(
              settings: widget.settings,
              toggleThemeMode: toggleThemeMode,
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.taskManager,
      required this.toggleThemeMode,
      required this.settings});
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
                        taskManager: widget.taskManager,
                      )
                    : Container(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryFixed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.list_rounded),
              onPressed: () {
                _onItemTapped(0);
              },
              color: Theme.of(context).colorScheme.onPrimaryFixed,
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                _onItemTapped(1);
              },
              color: Theme.of(context).colorScheme.onPrimaryFixed,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _onItemTapped(2);
              },
              color: Theme.of(context).colorScheme.onPrimaryFixed,
            ),
          ],
        ),
      ),
    );
  }
}
