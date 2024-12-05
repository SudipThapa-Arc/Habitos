import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  ReminderTime reminderTime;

  @HiveField(4)
  HabitFrequency frequency;

  @HiveField(5)
  int currentStreak;

  @HiveField(6)
  List<HabitRecord> records;

  Habit({
    String? id,
    required this.name,
    required this.reminderTime,
    required this.frequency,
    this.currentStreak = 0,
    List<HabitRecord>? records,
  })  : id = id ?? const Uuid().v4(),
        createdAt = DateTime.now(),
        records = records ?? [];

  bool isCompletedToday() {
    if (records.isEmpty) return false;
    final today = DateTime.now();
    return records.last.date.year == today.year &&
        records.last.date.month == today.month &&
        records.last.date.day == today.day;
  }

  void completeToday() {
    final today = DateTime.now();
    records.add(HabitRecord(date: today));
    currentStreak++;
  }
}

@HiveType(typeId: 1)
class ReminderTime {
  @HiveField(0)
  final int hour;

  @HiveField(1)
  final int minute;

  ReminderTime({required this.hour, required this.minute});
}

@HiveType(typeId: 2)
enum HabitFrequency {
  @HiveField(0)
  daily,
  
  @HiveField(1)
  weekly,
  
  @HiveField(2)
  custom
}

@HiveType(typeId: 3)
class HabitRecord {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final bool completed;

  HabitRecord({
    required this.date,
    this.completed = true,
  });
}