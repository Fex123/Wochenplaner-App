import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart' as app_settings;
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/main.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';

class LoginScreen extends StatefulWidget {
  final app_settings.Settings settings;
  final VoidCallback toggleThemeMode;

  const LoginScreen(
      {super.key, required this.settings, required this.toggleThemeMode});

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
      appBar: StaticComponents.staticAppBar('Settings', context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputBox(
                    labelText: "Insert Email",
                    controller: _emailController,
                    obscureText: false,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                  labelText: "Insert Password",
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
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              GestureDetector(
                onTap: () async {
                  final email = _emailController.text.trim();

                  if (!_isValidEmail(email)) {
                    setState(() {
                      _errorMessage = 'That\'s not a valid email address.';
                    });
                    return;
                  }

                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);
                    setState(() {
                      _errorMessage =
                          'Password reset email sent. Please check your inbox.';
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      if (e.code == 'user-not-found') {
                        _errorMessage = 'No user found for that email.';
                      } else {
                        _errorMessage = 'An error occurred. Please try again.';
                      }
                    });
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'An error occurred. Please try again.';
                    });
                  }
                },
                child: const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _errorMessage = '';
                  });
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (credential.user != null &&
                        !(credential.user?.emailVerified ?? false)) {
                      await FirebaseAuth.instance.signOut();
                      setState(() {
                        _errorMessage = 'Please verify your email to log in.';
                      });
                      return;
                    }
                    print('Login successful');

                    // Clear input fields
                    _emailController.clear();
                    _passwordController.clear();
                    TaskManager taskManager = TaskManager(credential.user!.uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          taskManager: taskManager,
                          settings: widget.settings,
                          toggleThemeMode: widget.toggleThemeMode,
                        ),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      if (e.code == 'invalid-credential') {
                        _errorMessage = 'User or password is incorrect.';
                      } else {
                        _errorMessage = 'An error occurred. Please try again.';
                      }
                    });
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'An error occurred. Please try again.';
                    });
                  }
                },
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text("Register"),
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
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputBox(
                    labelText: "Insert Email",
                    controller: _emailController,
                    obscureText: false,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                  labelText: "Insert Password",
                  controller: _passwordController,
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputBox(
                  labelText: "Confirm Password",
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
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
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
                      _errorMessage = 'That\'s not a valid email address.';
                    });
                    return;
                  }

                  if (password != confirmPassword) {
                    setState(() {
                      _errorMessage = 'Passwords do not match.';
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
                        _errorMessage = 'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        _errorMessage =
                            'The account already exists for that email.';
                      } else {
                        _errorMessage = 'An error occurred. Please try again.';
                      }
                    });
                  } catch (e) {
                    setState(() {
                      _errorMessage = 'An error occurred. Please try again.';
                    });
                  }
                },
                child: const Text("Register"),
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
