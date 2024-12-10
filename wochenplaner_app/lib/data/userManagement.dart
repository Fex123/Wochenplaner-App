import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart' as app_settings;
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/main.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  final app_settings.Settings settings;
  final VoidCallback toggleThemeMode;
  final void Function(Locale) changeLocale;

  const LoginScreen(
      {super.key,
      required this.settings,
      required this.toggleThemeMode,
      required this.changeLocale});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = ''; // Variable to hold error messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticComponents.staticAppBar(
          AppLocalizations.of(context)?.login ?? 'Login', context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputBox(
                    labelText: AppLocalizations.of(context)?.insert_email ??
                        "Insert Email",
                    controller: _emailController,
                    obscureText: false,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                  labelText: AppLocalizations.of(context)?.insert_password ??
                      "Insert Password",
                  controller: _passwordController,
                  obscureText: true,
                ),
              ),
              if (_errorMessage
                  .isNotEmpty) // Display error message if not empty
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              GestureDetector(
                onTap: () async {
                  final email = _emailController.text.trim();

                  if (!_isValidEmail(email)) {
                    setState(() {
                      _errorMessage =
                          AppLocalizations.of(context)?.invalid_email_address ??
                              'That\'s not a valid email address.';
                    });
                    return;
                  }

                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    setState(() {
                      _errorMessage = AppLocalizations.of(context)
                              ?.password_reset_email_sent ??
                          'Password reset email sent. Please check your inbox.';
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      if (e.code == 'user-not-found') {
                        _errorMessage = AppLocalizations.of(context)
                                ?.no_user_found_for_that_email ??
                            'No user found for that email.';
                      } else {
                        _errorMessage =
                            AppLocalizations.of(context)?.an_error_occurred ??
                                'An error occurred. Please try again.';
                      }
                    });
                  } catch (e) {
                    setState(() {
                      _errorMessage =
                          AppLocalizations.of(context)?.an_error_occurred ??
                              'An error occurred. Please try again.';
                    });
                  }
                },
                child: Text(
                  AppLocalizations.of(context)?.reset_password ??
                      "Reset Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    style: StaticStyles.appButtonStyle(context),
                    onPressed: () async {
                      setState(() {
                        _errorMessage = '';
                      });
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        if (credential.user != null &&
                            !(credential.user?.emailVerified ?? false)) {
                          await FirebaseAuth.instance.signOut();
                          setState(() {
                            _errorMessage = AppLocalizations.of(context)
                                    ?.please_verify_your_email ??
                                'Please verify your email to log in.';
                          });
                          return;
                        }
                        print('Login successful');

                        // Clear input fields
                        _emailController.clear();
                        _passwordController.clear();
                        TaskManager taskManager =
                            TaskManager(credential.user!.uid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                              taskManager: taskManager,
                              settings: widget.settings,
                              toggleThemeMode: widget.toggleThemeMode,
                              changeLocale: widget.changeLocale,
                            ),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          if (e.code == 'invalid-credential') {
                            _errorMessage = AppLocalizations.of(context)
                                    ?.user_or_password_incorrect ??
                                'User or password is incorrect.';
                          } else {
                            _errorMessage = _errorMessage =
                                AppLocalizations.of(context)
                                        ?.an_error_occurred ??
                                    'An error occurred. Please try again.';
                          }
                        });
                      } catch (e) {
                        setState(() {
                          _errorMessage = _errorMessage =
                              AppLocalizations.of(context)?.an_error_occurred ??
                                  'An error occurred. Please try again.';
                        });
                      }
                    },
                    child: Text(AppLocalizations.of(context)?.login ?? "Login"),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    style: StaticStyles.appButtonStyle(context),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                        AppLocalizations.of(context)?.register ?? "Register"),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = ''; // Variable to hold error messages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.register ?? 'Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputBox(
                    labelText: AppLocalizations.of(context)?.insert_email ??
                        "Insert Email",
                    controller: _emailController,
                    obscureText: false,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                  labelText: AppLocalizations.of(context)?.insert_password ??
                      "Insert Password",
                  controller: _passwordController,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                  labelText: AppLocalizations.of(context)?.confirm_password ??
                      "Confirm Password",
                  controller: _confirmPasswordController,
                  obscureText: true,
                ),
              ),
              if (_errorMessage
                  .isNotEmpty) // Display error message if not empty
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.onError),
                  ),
                ),
              ElevatedButton(
                style: StaticStyles.appButtonStyle(context),
                onPressed: () async {
                  setState(() {
                    _errorMessage = ''; // Clear previous error message
                  });
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  final confirmPassword =
                      _confirmPasswordController.text.trim();

                  if (!_isValidEmail(email)) {
                    setState(() {
                      _errorMessage =
                          AppLocalizations.of(context)?.invalid_email_address ??
                              'That\'s not a valid email address.';
                    });
                    return;
                  }

                  if (password != confirmPassword) {
                    setState(() {
                      _errorMessage = AppLocalizations.of(context)
                              ?.passwords_do_not_match ??
                          'Passwords do not match.';
                    });
                    return;
                  }

                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    await credential.user?.sendEmailVerification().then((_) {
                      print('Successfully sent email verification');
                    }).catchError((onError) {
                      print('Error sending email verification $onError');
                    });

                    print('Registration successful');
                    Navigator.pop(context); // Navigate back to login page
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      if (e.code == 'weak-password') {
                        _errorMessage =
                            AppLocalizations.of(context)?.password_too_weak ??
                                'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        _errorMessage = _errorMessage =
                            AppLocalizations.of(context)
                                    ?.email_already_in_use ??
                                'The account already exists for that email.';
                      } else {
                        _errorMessage =
                            AppLocalizations.of(context)?.an_error_occurred ??
                                'An error occurred. Please try again.';
                      }
                    });
                  } catch (e) {
                    setState(() {
                      _errorMessage =
                          AppLocalizations.of(context)?.an_error_occurred ??
                              'An error occurred. Please try again.';
                    });
                  }
                },
                child:
                    Text(AppLocalizations.of(context)?.register ?? "Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}

class InputBox extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const InputBox({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
