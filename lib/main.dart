import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/habit_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final habitProvider = HabitProvider();
  await habitProvider.initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: habitProvider),
      ],
      child: const HabitTrackerApp(),
    ),
  );
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, habitProvider, child) {
        return MaterialApp(
          title: 'Habit Tracker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: habitProvider.isDarkMode 
              ? Brightness.dark 
              : Brightness.light,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}