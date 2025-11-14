# CampusForum System Overview

A simple guide explaining how the CampusForum app works, how files are organized, and how everything connects together.

## 📋 Table of Contents

1. [What the App Does](#what-the-app-does)
2. [How Files Are Organized](#how-files-are-organized)
3. [How Pages Work](#how-pages-work)
4. [How Components Work](#how-components-work)
5. [How Navigation Works](#how-navigation-works)
6. [How State Management Works](#how-state-management-works)
7. [How Data Flows](#how-data-flows)
8. [Technologies Used](#technologies-used)

## 🎯 What the App Does

CampusForum is a campus community app where students can:
- **Post and discuss** - Create threads and comment on them
- **Join communities** - Create or join spaces (like Computer Science, Study Groups)
- **Share media** - Upload photos and videos
- **Get notifications** - See alerts about activities
- **Manage profiles** - Edit settings and view activity

The app works on phones, tablets, and web browsers.

## 📁 How Files Are Organized

### Main Folders

```
lib/                          # All your app code goes here
├── main.dart                 # App starts here - initializes everything
├── app.dart                  # Sets up the app (theme, router)
├── app_router.dart           # Defines all navigation routes
│
├── components/               # Reusable UI pieces
│   ├── thread_card.dart      # Shows a post preview card
│   ├── space_card.dart       # Shows a community card
│   ├── quick_post_composer.dart  # Form to create posts
│   ├── bottom_navigation.dart    # Bottom menu bar
│   ├── comment_card.dart     # Shows a comment
│   └── ...                   # More reusable pieces
│
├── pages/                    # Full screens
│   ├── splash_page.dart      # Welcome screen
│   ├── login_page.dart       # Login screen
│   ├── home_page.dart        # Main feed with posts
│   ├── spaces_page.dart      # Browse communities
│   ├── profile_page.dart     # Your profile
│   ├── thread_page.dart      # View a single post
│   └── ...                   # More screens
│
├── contexts/                 # State management
│   └── dark_mode_context.dart  # Manages dark/light mode
│
└── theme/                    # App styling
    └── app_theme.dart        # Colors, fonts, sizes
```

### What Each Folder Does

**`lib/components/`** - Reusable pieces
- These are like building blocks you use multiple times
- Example: `ThreadCard` is used on Home page, Spaces page, etc.
- Makes code cleaner and easier to maintain

**`lib/pages/`** - Full screens
- Each file is one complete screen
- Example: `home_page.dart` = the entire home screen
- Pages use components to build the UI

**`lib/contexts/`** - App-wide settings
- Stores data that multiple pages need
- Example: Dark mode preference (used everywhere)
- Uses Provider pattern to share data

**`lib/theme/`** - Looks and styling
- Defines colors, fonts, sizes
- Makes the app look consistent
- Easy to change the whole app's appearance

## 📄 How Pages Work

### What is a Page?

A page is a full screen in the app. Each page file creates one screen.

### Page Structure

```dart
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Local data for this page
  String selectedCategory = 'All';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          // Page content here
          // Uses components to build UI
        ],
      ),
      bottomNavigationBar: BottomNavigation(...),
    );
  }
}
```

### Types of Pages

**Authentication Pages:**
- `splash_page.dart` - Shows when app starts
- `login_page.dart` - User login
- `sign_up_page.dart` - Create account
- `onboarding_page.dart` - Tutorial for new users

**Main Pages:**
- `home_page.dart` - Main feed with all posts
- `spaces_page.dart` - Browse communities
- `profile_page.dart` - Your profile
- `notifications_page.dart` - Alerts and notifications
- `following_page.dart` - Posts from people you follow

**Detail Pages:**
- `thread_page.dart` - View one post with comments
- `user_profile_page.dart` - View someone else's profile
- `space_profile_page.dart` - View a community's page
- `settings_page.dart` - App settings

### How Pages Connect

Pages don't directly know about each other. They use the router to navigate:

```dart
// From home_page.dart, go to a thread
context.push('/thread/123');

// The router finds thread_page.dart and shows it
```

## 🧩 How Components Work

### What is a Component?

Components are reusable UI pieces. Think of them like LEGO blocks - you use the same block in different places.

### Example: ThreadCard Component

```dart
// This component shows a post preview
class ThreadCard extends StatelessWidget {
  final Map<String, dynamic> thread;  // Data to display
  final VoidCallback? onTap;            // What happens when clicked
  
  const ThreadCard({
    required this.thread,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(thread['title']),
        subtitle: Text(thread['author']),
        onTap: onTap,  // Call the function when tapped
      ),
    );
  }
}
```

### How Pages Use Components

```dart
// In home_page.dart
ListView.builder(
  itemCount: threads.length,
  itemBuilder: (context, index) {
    return ThreadCard(
      thread: threads[index],
      onTap: () {
        // Navigate to thread page
        context.push('/thread/${threads[index]['id']}');
      },
    );
  },
)
```

### Common Components

**Navigation:**
- `bottom_navigation.dart` - Bottom menu (Home, Spaces, Profile, etc.)

**Content Display:**
- `thread_card.dart` - Shows a post preview
- `space_card.dart` - Shows a community card
- `comment_card.dart` - Shows a comment

**Input:**
- `quick_post_composer.dart` - Form to create posts
- `comment_input.dart` - Input field for comments
- `password_input.dart` - Password field with show/hide

**Modals (Pop-ups):**
- `search_modal.dart` - Search overlay
- `settings_modal.dart` - Settings popup
- `create_space_modal.dart` - Create community popup

## 🧭 How Navigation Works

### The Router

All navigation is handled by `app_router.dart`. It's like a map that tells the app which page to show for each URL.

### Route Definitions

```dart
// In app_router.dart
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',  // Start here
  routes: [
    // Simple route - just show a page
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    
    // Route with parameter - like /user/john
    GoRoute(
      path: '/user/:username',
      builder: (context, state) {
        final username = state.pathParameters['username'];
        return UserProfilePage(username: username);
      },
    ),
  ],
);
```

### How to Navigate

**Go to a new page (can go back):**
```dart
context.push('/thread/123');
// Shows thread_page.dart, can press back button
```

**Replace current page (can't go back):**
```dart
context.go('/home');
// Goes to home, replaces current page
```

**Go back:**
```dart
if (context.canPop()) {
  context.pop();  // Go back if possible
} else {
  context.go('/home');  // Or go to home if can't go back
}
```

### Navigation Flow

```
App Starts
    ↓
Splash Screen (2 seconds)
    ↓
Login Page
    ↓
Onboarding (first time only)
    ↓
Home Page
    ├──→ Spaces Page
    │       └──→ Space Detail Page
    │               └──→ Thread Page
    │
    ├──→ Profile Page
    │       └──→ Settings Page
    │
    └──→ Thread Page
            └──→ User Profile Page
```

## 🔄 How State Management Works

### What is State?

State is data that can change. Examples:
- Is dark mode on or off?
- What posts are showing?
- Is a modal open or closed?

### Provider Pattern

We use **Provider** to share state across the app.

### Example: Dark Mode

**1. Create a Provider** (`dark_mode_context.dart`):
```dart
class DarkModeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    // Save to device storage
    await SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('darkMode', _isDarkMode));
    notifyListeners();  // Tell everyone it changed
  }
}
```

**2. Use it in a Page:**
```dart
// Get the provider
final darkMode = Provider.of<DarkModeProvider>(context);

// Use the value
bool isDark = darkMode.isDarkMode;

// Change it
darkMode.toggleDarkMode();  // This updates everywhere!
```

**3. Listen to Changes:**
```dart
Consumer<DarkModeProvider>(
  builder: (context, darkMode, child) {
    // This rebuilds automatically when dark mode changes
    return Text(darkMode.isDarkMode ? 'Dark' : 'Light');
  },
)
```

### Local State vs Global State

**Local State** (only in one page):
```dart
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';  // Only this page knows about this
  
  void changeCategory(String cat) {
    setState(() {
      selectedCategory = cat;  // Update and rebuild
    });
  }
}
```

**Global State** (shared across app):
```dart
// Dark mode - everyone needs to know
final darkMode = Provider.of<DarkModeProvider>(context);
```

## 🔀 How Data Flows

### Simple Flow Example

**User taps a button:**
```
1. User taps "Create Post" button
   ↓
2. Button's onPressed callback runs
   ↓
3. Function opens QuickPostComposer component
   ↓
4. User fills form and taps "Post"
   ↓
5. onSubmit callback runs
   ↓
6. Data is processed (could save to backend)
   ↓
7. Page updates to show new post
```

### Navigation Flow

```
User taps on a thread card
   ↓
ThreadCard's onTap runs
   ↓
context.push('/thread/123') called
   ↓
Router finds the route
   ↓
ThreadPage is created
   ↓
ThreadPage loads thread data
   ↓
ThreadPage displays the thread
```

### State Change Flow

```
User toggles dark mode
   ↓
Settings page calls darkMode.toggleDarkMode()
   ↓
DarkModeProvider updates _isDarkMode
   ↓
DarkModeProvider saves to SharedPreferences
   ↓
DarkModeProvider calls notifyListeners()
   ↓
All widgets using Consumer rebuild
   ↓
App theme changes everywhere
```

## 🛠️ Technologies Used

### Core
- **Flutter** - The framework (like React for mobile)
- **Dart** - The programming language

### Key Packages

**Navigation:**
- `go_router` - Handles all page navigation

**State Management:**
- `provider` - Shares data across the app

**Storage:**
- `shared_preferences` - Saves settings to device

**Media:**
- `image_picker` - Lets users pick photos/videos

**UI:**
- `google_fonts` - Custom fonts (Poppins)

### Platform Support

- ✅ **Android** - Full support
- ✅ **iOS** - Full support
- ⚠️ **Web** - Works but some features limited (like image picker)
- ✅ **Windows** - Supported
- ✅ **macOS** - Supported
- ✅ **Linux** - Supported

## 🎨 How Everything Connects

### Example: Viewing a Thread

```
1. User is on HomePage
   ↓
2. HomePage shows list of ThreadCard components
   ↓
3. User taps a ThreadCard
   ↓
4. ThreadCard's onTap calls: context.push('/thread/123')
   ↓
5. Router finds '/thread/:threadId' route
   ↓
6. Router creates ThreadPage with threadId = '123'
   ↓
7. ThreadPage loads thread data
   ↓
8. ThreadPage uses CommentCard components to show comments
   ↓
9. User can comment using CommentInput component
   ↓
10. CommentInput submits, ThreadPage updates
```

### Example: Creating a Post

```
1. User on HomePage taps "Create Post"
   ↓
2. HomePage shows QuickPostComposer component
   ↓
3. User fills form (title, content, category, maybe image)
   ↓
4. User taps "Post" button
   ↓
5. QuickPostComposer's onSubmit callback runs
   ↓
6. Data sent to HomePage
   ↓
7. HomePage adds new post to list
   ↓
8. HomePage rebuilds, showing new post
```

## 💡 Key Concepts for New Developers

### 1. Widget Tree
Everything in Flutter is a widget. Pages are widgets, components are widgets, even text is a widget. They're nested like a tree.

### 2. Stateful vs Stateless
- **StatelessWidget** - Doesn't change (like a static image)
- **StatefulWidget** - Can change (like a form with input)

### 3. Build Method
Every widget has a `build()` method that returns what to show on screen. Flutter calls this when it needs to display the widget.

### 4. Context
`context` is like a reference to where you are in the widget tree. You use it for:
- Navigation: `context.push('/route')`
- Getting providers: `Provider.of<Type>(context)`
- Getting theme: `Theme.of(context)`

### 5. setState
When you change data in a StatefulWidget, call `setState()` to tell Flutter to rebuild the widget.

```dart
setState(() {
  selectedCategory = 'New Category';  // Change data
  // Flutter will rebuild this widget
});
```

## 🚀 Common Patterns

### Pattern 1: List of Items
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemCard(item: items[index]);
  },
)
```

### Pattern 2: Conditional Rendering
```dart
if (isLoading)
  CircularProgressIndicator()
else
  ContentWidget()
```

### Pattern 3: Navigation with Data
```dart
// Pass data through route
context.push('/user/$username');

// Or use query parameters
context.push('/search?q=$searchTerm');
```

## 📚 Where to Start

**New to the codebase? Start here:**

1. **Read `main.dart`** - See how the app starts
2. **Read `app_router.dart`** - See all the routes
3. **Pick a simple page** - Like `splash_page.dart`
4. **See how it uses components** - Check what components it imports
5. **Follow the flow** - See how user actions trigger navigation

**Want to add a feature?**

1. Create the page in `lib/pages/`
2. Add route in `app_router.dart`
3. Create components in `lib/components/` if needed
4. Connect everything with navigation

---

**Document Version**: 1.0  
**Last Updated**: 2024  
**For**: New developers joining the project
