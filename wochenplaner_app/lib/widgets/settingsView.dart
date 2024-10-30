import 'package:flutter/material.dart';
import 'package:wochenplaner_app/data/settings.dart';

class SettingsView extends StatefulWidget {
  final VoidCallback toggleThemeMode;
  final Settings settings;

  const SettingsView({super.key, required this.toggleThemeMode, required this.settings});

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late double startHour;
  late double endHour;

  @override
  void initState() {
    super.initState();
    startHour = widget.settings.getStartHour().toDouble();
    endHour = widget.settings.getEndHour().toDouble();
  }

  void updateStartHour(double value) {
    setState(() {
      startHour = value;
      widget.settings.setStartHour(value.toInt());
      endHour = widget.settings.getEndHour().toDouble(); // Update endHour based on settings
    });
  }

  void updateEndHour(double value) {
    setState(() {
      endHour = value;
      widget.settings.setEndHour(value.toInt());
      startHour = widget.settings.getStartHour().toDouble(); // Update startHour based on settings
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomSwitch(
                toggleState: widget.toggleThemeMode,
                description: 'Activate dark mode'),
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
        ],
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final VoidCallback toggleState;
  final String description;

  const CustomSwitch(
      {super.key, required this.toggleState, required this.description});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool darkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.description),
        Switch(
          onChanged: (bool value) {
            setState(() {
              darkTheme = value;
              widget.toggleState();
            });
          },
          value: darkTheme,
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

  const CustomSlider({super.key, required this.value, required this.onChanged, required this.min, 
  required this.max, required this.description});

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
                divisions: (widget.max > widget.min) ? widget.max - widget.min : null,
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
