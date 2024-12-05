# Habit Tracker 🏆

## Overview
Habit Tracker is a minimalistic Flutter application designed to help users build and maintain positive habits. Track your daily progress, maintain streaks, and stay motivated with easy-to-use habit tracking features.

## Features ✨

### Habit Management
- Create custom habits with personalized details
- Track daily habit completions
- View habit streaks and progress

### Customization
- Set habit frequencies (Daily, Weekly, Custom)
- Configure reminder times for each habit
- Toggle dark/light mode
- Enable/disable notifications

## Screenshots
[//TODO: Add app screenshots]

## Getting Started 🚀

### Prerequisites
- Flutter SDK (3.13.0 or higher)
- Dart SDK
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/habit_tracker.git
cd habit_tracker
```

2. Install dependencies
```bash
flutter pub get
flutter pub run build_runner build
```

3. Run the app
```bash
flutter run
```

## Technologies Used 💻
- Flutter
- Provider (State Management)
- Hive (Local Storage)
- Flutter Local Notifications

## Project Structure
```
lib/
├── models/
│   └── habit_model.dart
├── providers/
│   └── habit_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── add_habit_screen.dart
└── main.dart
```

## Future Roadmap 🗺️
- [ ] Cloud synchronization
- [ ] Advanced analytics
- [ ] Export/Import habits
- [ ] Widget support
- [ ] More detailed streak tracking

## Contributing 🤝
Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄
Distributed under the MIT License. See `LICENSE` for more information.
