# CampusForum

A modern, cross-platform campus community forum application built with Flutter. CampusForum enables students to connect, share ideas, join study groups, participate in discussions, and discover campus events through an intuitive and responsive interface.

## 📱 Features

### Core Features
- **User Authentication**: Secure login and sign-up system
- **Thread Discussions**: Create, view, and interact with discussion threads
- **Spaces/Communities**: Join and create interest-based communities (e.g., Computer Science, Study Groups, Events)
- **Real-time Notifications**: Stay updated with alerts and notifications
- **User Profiles**: Customizable user profiles with activity tracking
- **Dark Mode**: System-wide dark mode support with persistent preferences
- **Media Support**: Upload and share photos and videos in posts
- **Category Filtering**: Filter content by categories (Academics, Events, Clubs, etc.)
- **Search Functionality**: Search for threads, users, and spaces
- **Responsive Design**: Auto-adjusting layouts for different screen sizes

### User Experience
- **Onboarding**: Guided introduction for new users
- **Bottom Navigation**: Easy navigation between main sections
- **Thread Interactions**: Like, comment, and view thread details
- **Profile Management**: Edit profile settings, username, and preferences
- **Space Management**: Create, edit, and manage community spaces

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** (SDK: ^3.9.2)
- **Dart**

### Key Dependencies
- **go_router** (^13.0.0): Declarative routing for navigation
- **provider** (^6.1.1): State management solution
- **shared_preferences** (^2.2.2): Local data persistence
- **image_picker** (^1.0.7): Image and video selection from gallery/camera
- **google_fonts** (^6.1.0): Custom typography (Poppins font family)

### Development Tools
- **flutter_lints** (^5.0.0): Linting rules for code quality

## 📁 Project Structure

```
campusforum/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── app.dart                  # Main app widget with theme configuration
│   ├── app_router.dart           # Route definitions using go_router
│   ├── components/               # Reusable UI components
│   │   ├── bottom_navigation.dart
│   │   ├── category_chips.dart
│   │   ├── comment_card.dart
│   │   ├── comment_input.dart
│   │   ├── quick_post_composer.dart
│   │   ├── thread_card.dart
│   │   ├── space_card.dart
│   │   └── ... (other components)
│   ├── pages/                    # Screen/page widgets
│   │   ├── splash_page.dart
│   │   ├── login_page.dart
│   │   ├── home_page.dart
│   │   ├── spaces_page.dart
│   │   ├── profile_page.dart
│   │   └── ... (other pages)
│   ├── contexts/                 # State management providers
│   │   └── dark_mode_context.dart
│   └── theme/                    # Theme configuration
│       └── app_theme.dart
├── android/                      # Android platform files
├── ios/                          # iOS platform files
├── web/                          # Web platform files
├── windows/                      # Windows platform files
├── linux/                        # Linux platform files
├── macos/                        # macOS platform files
└── pubspec.yaml                  # Project dependencies and configuration
```

## 🚀 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.9.2 or higher)
  - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
  - Verify installation: `flutter --version`
- **Dart SDK** (included with Flutter)
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA with Flutter plugins
- **Platform-specific tools**:
  - **Android**: Android Studio with Android SDK
  - **iOS**: Xcode (macOS only)
  - **Web**: Chrome browser for testing

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd campusforum
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter setup**
   ```bash
   flutter doctor
   ```
   Ensure all required components are installed and configured.

4. **Platform-specific setup** (if needed):
   
   **Android:**
   - Open `android/` folder in Android Studio
   - Sync Gradle files
   - Ensure Android SDK is properly configured
   
   **iOS** (macOS only):
   - Open `ios/Runner.xcworkspace` in Xcode
   - Configure signing and capabilities
   - Install CocoaPods: `cd ios && pod install`

## 🏃 Running the Application

### Development Mode

**Run on connected device/emulator:**
```bash
flutter run
```

**Run on specific platform:**
```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

**Run in debug mode with hot reload:**
```bash
flutter run --debug
```

**Run in release mode:**
```bash
flutter run --release
```

### List Available Devices
```bash
flutter devices
```

## 🏗️ Building the Application

### Build for Production

**Android APK:**
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

**Android App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

**iOS** (macOS only):
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```
Output: `build/web/`

**Windows:**
```bash
flutter build windows --release
```

**macOS:**
```bash
flutter build macos --release
```

**Linux:**
```bash
flutter build linux --release
```

### Build Configuration

Edit `pubspec.yaml` to configure:
- App version
- App name
- Icons and assets
- Platform-specific settings

## 🔧 Environment Variables

Currently, the application uses local state management and doesn't require external environment variables. However, if you plan to integrate with a backend API, you may need to configure:

### Optional Environment Setup

Create a `.env` file in the root directory (if using a package like `flutter_dotenv`):

```env
# API Configuration (example)
API_BASE_URL=https://api.example.com
API_KEY=your_api_key_here

# Feature Flags (example)
ENABLE_ANALYTICS=true
ENABLE_CRASH_REPORTING=false
```

Then add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_dotenv: ^5.0.0
```

## 📖 Usage Guide

### Getting Started

1. **Launch the app**: The app starts with a splash screen, then navigates to the login page.

2. **Authentication**:
   - Sign up for a new account or log in with existing credentials
   - Complete the onboarding process to get familiar with features

3. **Main Navigation**:
   - **Home**: Browse and interact with threads and posts
   - **Spaces**: Discover and join community spaces
   - **Alerts**: View notifications and updates
   - **Profile**: Access your profile and settings

### Key Features Usage

**Creating a Post:**
1. Navigate to Home or a Space page
2. Tap the "Create Post" composer
3. Select a category, add title and content
4. Optionally attach a photo or video
5. Tap "Post" to publish

**Joining a Space:**
1. Go to the Spaces page
2. Browse available spaces or create a new one
3. Tap on a space to view details and join

**Viewing Threads:**
1. Browse threads on the Home page
2. Tap on a thread to view full details and comments
3. Like, comment, or share threads

**Managing Profile:**
1. Go to Profile tab
2. Tap settings icon to edit username, preferences, and theme
3. View your activity and posts

**Dark Mode:**
- Toggle dark mode from Settings page
- Preference is saved and persists across app restarts

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run tests with coverage:
```bash
flutter test --coverage
```

## 🐛 Troubleshooting

### Common Issues

**Issue: `flutter pub get` fails**
- Solution: Check your internet connection and Flutter SDK version
- Run `flutter clean` and try again

**Issue: Build fails on Android**
- Solution: Ensure Android SDK is properly installed
- Check `android/local.properties` for correct SDK path
- Run `flutter clean` and rebuild

**Issue: Image picker not working on web**
- Solution: Image picker has limited support on web. Use mobile device or emulator for full functionality.

**Issue: Hot reload not working**
- Solution: Press `R` in terminal for hot restart, or `r` for hot reload
- If issues persist, stop and restart the app

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Follow Flutter/Dart style guidelines
   - Write clear commit messages
   - Test your changes thoroughly
4. **Commit your changes**
   ```bash
   git commit -m "Add: Description of your changes"
   ```
5. **Push to your branch**
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Create a Pull Request**
   - Provide a clear description of changes
   - Reference any related issues

### Code Style
- Follow Dart style guide: [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Run `flutter analyze` before committing
- Ensure all tests pass

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Contact the development team

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for Poppins typography
- All contributors and testers

---

**Version**: 0.1.0  
**Last Updated**: 2024
