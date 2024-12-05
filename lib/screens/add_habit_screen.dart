import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit_model.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  String _habitName = '';
  TimeOfDay _reminderTime = TimeOfDay.now();
  HabitFrequency _frequency = HabitFrequency.daily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Habit Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
                onSaved: (value) => _habitName = value!,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Reminder Time'),
                trailing: Text(_reminderTime.format(context)),
                onTap: _selectTime,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<HabitFrequency>(
                value: _frequency,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(),
                ),
                items: HabitFrequency.values
                    .map((freq) => DropdownMenuItem(
                          value: freq,
                          child: Text(freq.toString().split('.').last),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _frequency = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveHabit,
                child: const Text('Create Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
    }
  }

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final habit = Habit(
        name: _habitName,
        frequency: _frequency,
        reminderTime: ReminderTime(
          hour: _reminderTime.hour,
          minute: _reminderTime.minute,
        ),
      );

      Provider.of<HabitProvider>(context, listen: false).addHabit(habit);
      Navigator.pop(context);
    }
  }
}