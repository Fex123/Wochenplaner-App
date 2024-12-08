import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart';
import 'package:wochenplaner_app/staticAppVariables.dart';
import 'package:wochenplaner_app/data/taskStorage.dart';
import 'package:wochenplaner_app/data/userManagement.dart'; // Add this import

class SettingsView extends StatefulWidget {
  final VoidCallback toggleThemeMode;
  final Settings settings;
  final TaskManager taskManager;

  const SettingsView(
      {super.key,
      required this.toggleThemeMode,
      required this.settings,
      required this.taskManager,});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late double startHour;
  late double endHour;
  late bool selectedHalfHourLines;

  @override
  void initState() {
    super.initState();
    startHour = widget.settings.getStartHour().toDouble();
    endHour = widget.settings.getEndHour().toDouble();
    selectedHalfHourLines = widget.settings.getSelectedHalfHourLines();
  }

  void updateStartHour(double value) {
    setState(() {
      startHour = value;
      widget.settings.setStartHour(value.toInt());
      endHour = widget.settings
          .getEndHour()
          .toDouble(); // Update endHour based on settings
    });
  }

  void updateEndHour(double value) {
    setState(() {
      endHour = value;
      widget.settings.setEndHour(value.toInt());
      startHour = widget.settings
          .getStartHour()
          .toDouble(); // Update startHour based on settings
    });
  }

  void toggleHalfHourLines() {
    setState(() {
      selectedHalfHourLines = !selectedHalfHourLines;
      widget.settings.setSelectedHalfHourLines(selectedHalfHourLines);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticComponents.staticAppBar('Settings', context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomSwitch(
              toggleState: widget.toggleThemeMode,
              description: 'Activate dark mode',
              settings: widget.settings,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomSlider(
                  value: startHour,
                  onChanged: (double value) {
                    updateStartHour(value);
                  },
                  min: 0,
                  max: (endHour - 1).toInt(),
                  description: 'Set Calendar view range from:',
                ),
                CustomSlider(
                  value: endHour,
                  onChanged: (double value) {
                    updateEndHour(value);
                  },
                  min: (startHour + 1).toInt(),
                  max: 24,
                  description: 'To:',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomSwitch(
                  toggleState: toggleHalfHourLines,
                  description: "Show half Hour Lines",
                  settings: widget.settings,
                  getValue: () => widget.settings.getSelectedHalfHourLines(),
                  setValue: (bool value) => widget.settings.setSelectedHalfHourLines(value),
                ),
              ],
            ),
          ),        
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              if (widget.settings.getAutoLogin()) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen(
                              settings: widget.settings,
                              toggleThemeMode: widget.toggleThemeMode,
                            )));
              } else {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Account Logout'),
          ),
          ElevatedButton(
            onPressed: () {
              widget.taskManager.deleteCollection();
              FirebaseAuth.instance.currentUser!.delete();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final VoidCallback toggleState;
  final String description;
  final Settings settings;
  final bool Function()? getValue;
  final Function(bool)? setValue;

  const CustomSwitch({
    super.key,
    required this.toggleState,
    required this.description,
    required this.settings,
    this.getValue,
    this.setValue,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.description),
        Switch(
          onChanged: (bool value) {
            setState(() {
              if (widget.setValue != null && widget.getValue != null) {
                widget.setValue!(value);
              } else {
                widget.settings.setDarkMode(value);
              }
              widget.toggleState();
            });
          },
          value: widget.getValue?.call() ?? widget.settings.isDarkMode(),
        ),
      ],
    );
  }
}

class CustomSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final int min;
  final int max;
  final String description;

  const CustomSlider(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.min,
      required this.max,
      required this.description});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value = widget.value;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.description),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.min.toString()),
            Expanded(
              child: Slider(
                value: _value,
                min: widget.min.toDouble(),
                max: widget.max.toDouble(),
                divisions:
                    (widget.max > widget.min) ? widget.max - widget.min : null,
                label: _value.toInt().toString(),
                onChanged: (double value) {
                  setState(() {
                    _value = value.roundToDouble();
                    widget.onChanged(_value);
                  });
                },
              ),
            ),
            Text(widget.max.toString()),
          ],
        ),
      ],
    );
  }
}
class CustomRadioButton extends StatefulWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;
  final String description;

  const CustomRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.description});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            value: widget.value,
            groupValue: widget.groupValue,
            onChanged: (int? value) {
              setState(() {
                widget.onChanged(widget.value);
              });
            },
          ),
          Text(
            widget.description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}