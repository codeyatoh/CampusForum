# CampusForum

A modern campus community forum app built with Flutter. Students can connect, share ideas, join study groups, and participate in discussions.

## 📱 What This App Does

CampusForum lets students:
- **Create and join discussions** - Post threads and comment on them
- **Join communities** - Create or join spaces based on interests (Computer Science, Study Groups, Events, etc.)
- **Share media** - Upload photos and videos in posts
- **Get notifications** - Stay updated with alerts
- **Manage profiles** - Customize your profile and settings
- **Dark mode** - Switch between light and dark themes
- **Search and filter** - Find content by categories or keywords

## 🛠️ Tech Stack

### What We Use
- **Flutter** - Framework for building the app
- **Dart** - Programming language
- **go_router** - For navigation between screens
- **provider** - For managing app state (like dark mode)
- **shared_preferences** - For saving user settings
- **image_picker** - For selecting photos/videos
- **google_fonts** - For custom fonts (Poppins)

## 📁 How Files Are Organized

```
campusforum/
├── lib/                          # Main app code
│   ├── main.dart                 # App starts here
│   ├── app.dart                  # App configuration
│   ├── app_router.dart           # All navigation routes
│   │
│   ├── components/               # Reusable UI pieces
│   │   ├── thread_card.dart      # Shows a post preview
│   │   ├── space_card.dart       # Shows a community card
│   │   ├── quick_post_composer.dart  # Create new posts
│   │   ├── bottom_navigation.dart    # Bottom menu bar
│   │   └── ...                   # Other reusable components
│   │
│   ├── pages/                    # Full screens/pages
│   │   ├── splash_page.dart      # Welcome screen
│   │   ├── login_page.dart       # Login screen
│   │   ├── home_page.dart        # Main feed
│   │   ├── spaces_page.dart      # Browse communities
│   │   ├── profile_page.dart     # Your profile
│   │   └── ...                   # Other pages
│   │
│   ├── contexts/                 # State management
│   │   └── dark_mode_context.dart  # Dark mode settings
│   │
│   └── theme/                    # App styling
│       └── app_theme.dart        # Colors, fonts, etc.
│
├── android/                      # Android-specific files
├── ios/                          # iOS-specific files
├── web/                          # Web-specific files
├── windows/                      # Windows-specific files
├── macos/                        # macOS-specific files
├── linux/                        # Linux-specific files
└── pubspec.yaml                  # Dependencies list
```

## 🚀 Installation Guide

### Step 1: Install Prerequisites

**You need:**
- Flutter SDK (version 3.9.2 or higher)
  - Download: https://flutter.dev/docs/get-started/install
  - Check if installed: Open terminal and type `flutter --version`
- An IDE (code editor):
  - **VS Code** (recommended) - Install Flutter extension
  - **Android Studio** - Install Flutter plugin
- For Android: Android Studio with Android SDK
- For iOS (Mac only): Xcode

### Step 2: Get the Code

```bash
# Clone the repository
git clone https://github.com/codeyatoh/CampusForum.git

# Go into the project folder
cd CampusForum
```

### Step 3: Install Dependencies

```bash
# Get all required packages
flutter pub get
```

### Step 4: Check Your Setup

```bash
# Make sure everything is installed correctly
flutter doctor
```

This will show you what's installed and what's missing. Fix any issues it reports.

## 🏃 How to Run the App

### Run on Your Device/Emulator

**Basic command:**
```bash
flutter run
```

**Run on specific platform:**
```bash
# Android
flutter run -d android

# iOS (Mac only)
flutter run -d ios

# Web browser
flutter run -d chrome

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

**See available devices:**
```bash
flutter devices
```

### Development Tips

- **Hot Reload**: Press `r` in terminal to see changes instantly
- **Hot Restart**: Press `R` to restart the app
- **Stop App**: Press `q` to quit

## 🏗️ Building for Release

### Android

**Create APK file:**
```bash
flutter build apk --release
```
File location: `build/app/outputs/flutter-apk/app-release.apk`

**Create App Bundle (for Google Play Store):**
```bash
flutter build appbundle --release
```

### iOS (Mac only)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```
Files will be in: `build/web/`

### Windows
```bash
flutter build windows --release
```

### macOS
```bash
flutter build macos --release
```

### Linux
```bash
flutter build linux --release
```

## 🔧 Environment Variables

Currently, the app doesn't need any environment variables. Everything works locally.

**If you add a backend later**, you might need:
- API URL
- API keys
- Database connection strings

You can add these using a `.env` file if needed.

## 📖 How to Use the App

### First Time Setup

1. **Open the app** - You'll see a splash screen
2. **Login or Sign Up** - Create an account or log in
3. **Onboarding** - Follow the tutorial to learn the features
4. **Start exploring** - You're ready to use the app!

### Main Features

**Home Page:**
- Browse all posts and discussions
- Create new posts
- Filter by categories
- Search for content

**Spaces Page:**
- Browse communities
- Join or create spaces
- See posts from specific communities

**Profile Page:**
- View your profile
- See your posts and activity
- Access settings

**Notifications:**
- See alerts and updates
- Get notified about new comments, likes, etc.

**Creating a Post:**
1. Go to Home or a Space
2. Tap "Create Post" button
3. Choose a category
4. Write title and content
5. (Optional) Add photo or video
6. Tap "Post"

**Joining a Space:**
1. Go to Spaces page
2. Browse or search for spaces
3. Tap on a space to view details
4. Tap "Join" button

## 🐛 Troubleshooting

### Problem: `flutter pub get` fails
**Solution:**
- Check your internet connection
- Make sure Flutter is installed: `flutter --version`
- Try: `flutter clean` then `flutter pub get` again

### Problem: App won't build on Android
**Solution:**
- Make sure Android Studio is installed
- Check that Android SDK is set up
- Run `flutter clean` and try again

### Problem: Image picker doesn't work on web
**Solution:**
- Image picker has limited web support
- Use a mobile device or emulator for full functionality

### Problem: Hot reload not working
**Solution:**
- Press `R` (capital) for hot restart
- Or stop the app and run `flutter run` again

### Problem: Can't find device
**Solution:**
- Run `flutter devices` to see available devices
- Make sure your phone/emulator is connected
- For Android: Enable USB debugging
- For iOS: Trust the computer on your device

## 🧪 Testing

**Run all tests:**
```bash
flutter test
```

**Run tests with coverage report:**
```bash
flutter test --coverage
```

## 🤝 Contributing

Want to help improve the app? Here's how:

1. **Fork the repository** on GitHub
2. **Create a new branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
   - Write clear code
   - Test your changes
   - Follow Flutter style guide
4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "Add: Description of what you did"
   ```
5. **Push to GitHub:**
   ```bash
   git push origin feature/your-feature-name
   ```
6. **Create a Pull Request** on GitHub

### Code Style
- Follow Dart style guide
- Run `flutter analyze` before committing
- Make sure tests pass

## 📄 License

This project is licensed under the MIT License.

## 📞 Support

Need help?
- Open an issue on GitHub
- Contact the development team

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for Poppins typography
- All contributors and testers

---

**Version**: 0.1.0  
**Last Updated**: 2024
