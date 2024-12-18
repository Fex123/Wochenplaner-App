import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/data/userManagement.dart';
import 'package:wochenplaner_app/widgets/clandarView.dart';
import 'package:wochenplaner_app/widgets/settingsView.dart';
import 'package:wochenplaner_app/widgets/taskListView.dart';
import 'package:wochenplaner_app/altTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Settings settings = Settings();
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    settings.setAutoLogin(true);
  }
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
  Locale _locale = Locale('en'); // Default locale

  void toggleThemeMode() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
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
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('de'), Locale('en')],
      locale: _locale,
      title: 'Wochenplaner',
      theme: mainTheme.light(),
      darkTheme: mainTheme.dark(),
      themeMode: _themeMode,
      home: widget.isLoggedIn
          ? MyHomePage(
              taskManager: TaskManager(FirebaseAuth.instance.currentUser!.uid),
              toggleThemeMode: toggleThemeMode,
              changeLocale: _changeLanguage,
              settings: widget.settings,
            )
          : LoginScreen(
              settings: widget.settings,
              toggleThemeMode: toggleThemeMode,
              changeLocale: _changeLanguage,
            ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.taskManager,
      required this.toggleThemeMode,
      required this.settings,
      required this.changeLocale});
  final VoidCallback toggleThemeMode;
  final void Function(Locale) changeLocale;
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
                        changeLocale: widget.changeLocale,
                        settings: widget.settings,
                        taskManager: widget.taskManager,
                      )
                    : Container(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.list_rounded),
              onPressed: () {
                _onItemTapped(0);
              },
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                _onItemTapped(1);
              },
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _onItemTapped(2);
              },
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
