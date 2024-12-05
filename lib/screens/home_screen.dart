import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../models/habit_model.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsBottomSheet(context),
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final habits = habitProvider.habits;
          
          if (habits.isEmpty) {
            return const Center(
              child: Text(
                'No habits yet. Add a new habit!',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return HabitTile(habit: habit);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddHabitScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final habitProvider = Provider.of<HabitProvider>(context);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                value: habitProvider.notificationsEnabled,
                onChanged: (value) => habitProvider.toggleNotifications(value),
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: habitProvider.isDarkMode,
                onChanged: (value) => habitProvider.toggleDarkMode(value),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HabitTile extends StatelessWidget {
  final Habit habit;

  const HabitTile({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(habit.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: habit.isCompletedToday() ? 1.0 : 0.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                habit.isCompletedToday() ? Colors.green : Colors.blue,
              ),
            ),
            Text('Streak: ${habit.currentStreak} days'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            habit.isCompletedToday() 
              ? Icons.check_circle 
              : Icons.check_circle_outline,
            color: habit.isCompletedToday() ? Colors.green : null,
          ),
          onPressed: habit.isCompletedToday()
            ? null 
            : () {
                Provider.of<HabitProvider>(context, listen: false)
                  .completeHabit(habit);
              },
        ),
      ),
    );
  }
}