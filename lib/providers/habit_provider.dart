import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  static const String _habitsBoxName = 'habits';
  late Box<Habit> _habitBox;
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  List<Habit> get habits => _habitBox.values.toList();
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isDarkMode => _isDarkMode;

  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(ReminderTimeAdapter());
    Hive.registerAdapter(HabitFrequencyAdapter());
    Hive.registerAdapter(HabitRecordAdapter());

    _habitBox = await Hive.openBox<Habit>(_habitsBoxName);
    notifyListeners();
  }

  void addHabit(Habit habit) {
    _habitBox.add(habit);
    notifyListeners();
  }

  void updateHabit(Habit habit) {
    habit.save();
    notifyListeners();
  }

  void deleteHabit(Habit habit) {
    habit.delete();
    notifyListeners();
  }

  void completeHabit(Habit habit) {
    habit.completeToday();
    habit.save();
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}