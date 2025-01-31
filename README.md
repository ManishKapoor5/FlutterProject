# Quiz App

A gamified quiz application built with Flutter that fetches questions from an API and provides an interactive learning experience.


## 🎥 Demo Video

[Watch the demo video here](https://streamable.com/auy77f)

## ✨ Features

- Dynamic question loading from API
- Interactive UI with animated feedback
- Score tracking and progress bar
- Detailed solutions for each question
- Beautiful purple theme with material design
- Responsive layout for all screen sizes
- Performance optimized with proper state management

## 🛠️ Technical Details

### Project Structure
```
lib/
  ├── models/
  │   └── question.dart     # Data models for questions and options
  ├── services/
  │   └── quiz_service.dart # API integration service
  ├── screens/
  │   └── quiz_screen.dart  # Main quiz UI
  └── main.dart            # App entry point
```

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/quiz_app.git
   cd quiz_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

The app uses a REST API endpoint for fetching questions. The API URL can be configured in `lib/services/quiz_service.dart`:

```dart
static const String apiUrl = 'https://api.jsonserve.com/Uw5CrX';
```

## 🧪 Testing

To run the tests:
```bash
flutter test
```

The app includes widget tests to ensure proper functionality:
- Initial score display
- Loading indicator
- Question rendering
- Answer selection
- Score calculation

## 📱 Platform Support

- ✅ Android
- ✅ iOS
- ✅ Web

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the beautiful UI components
- Test API provider for the quiz questions

## 📞 Contact - 7678326868

Manish Kapoor - [@ManishK24941877](https://x.com/ManishK24941877)

Project Link: [https://github.com/manishkapoor5/FlutterProject](https://github.com/manishkapoor5/FlutterProject)
