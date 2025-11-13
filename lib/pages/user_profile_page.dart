import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/bottom_navigation.dart';
import '../components/thread_card.dart';
import '../theme/app_theme.dart';

class UserProfilePage extends StatefulWidget {
  final String username;

  const UserProfilePage({super.key, required this.username});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isFollowing = false;

  final Map<String, String> _userAvatars = {
    'StudyBuddy': '😊',
    'EventPlanner': '😎',
    'CourseHunter': '🤓',
    'BookWorm': '🐼',
    'TechGuru': '🦊',
  };

  String get _userAvatar {
    return _userAvatars[widget.username] ?? '😊';
  }

  final List<Map<String, dynamic>> _userPosts = [
    {
      'id': 1,
      'title': 'Study Group for Finals',
      'content':
          'Looking for people to study with for the upcoming finals.',
      'author': 'StudyBuddy',
      'avatar': '😊',
      'time': '2h ago',
      'likes': 24,
      'comments': 8,
      'views': 156,
    },
    {
      'id': 2,
      'title': 'Great Resources',
      'content': 'Found some amazing study materials for CS101.',
      'author': 'StudyBuddy',
      'avatar': '😊',
      'time': '1d ago',
      'likes': 42,
      'comments': 15,
      'views': 234,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground;
    final surfaceColor = isDarkMode ? AppTheme.darkSurface : AppTheme.lightSurface;
    final textColor = isDarkMode ? AppTheme.darkText : AppTheme.lightText;
    final secondaryTextColor = isDarkMode ? AppTheme.darkSecondaryText : AppTheme.lightSecondaryText;
    
    // Get screen dimensions for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Header with back button
          SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: isSmallScreen ? 8 : 12,
              ),
              decoration: BoxDecoration(
                color: surfaceColor,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: textColor,
                      size: isSmallScreen ? 20 : 24,
                    ),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/home');
                      }
                    },
                  ),
                  Expanded(
                    child: Text(
                      widget.username,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Profile Section
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 16,
              vertical: isSmallScreen ? 12 : 12,
            ),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: isSmallScreen ? 70 : 80,
                  height: isSmallScreen ? 70 : 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B4513),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      _userAvatar,
                      style: TextStyle(fontSize: isSmallScreen ? 28 : 32),
                    ),
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 12),
                Text(
                  widget.username,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 18 : 20,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '@${widget.username}',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16),
                  child: Text(
                    'Student at Campus University | CS Major | Coffee enthusiast ☕',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10 : 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${_userPosts.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 16 : 18,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: isSmallScreen ? 12 : 16),
                    Column(
                      children: [
                        Text(
                          '87',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 16 : 18,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: isSmallScreen ? 12 : 16),
                    Column(
                      children: [
                        Text(
                          '52',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 16 : 18,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: isSmallScreen ? 10 : 12),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFollowing = !_isFollowing;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFollowing
                        ? Colors.white
                        : const Color(0xFF8B4513),
                    foregroundColor: _isFollowing
                        ? const Color(0xFF8B4513)
                        : Colors.white,
                    side: _isFollowing
                        ? const BorderSide(color: Color(0xFF8B4513))
                        : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 24 : 32,
                      vertical: isSmallScreen ? 10 : 12,
                    ),
                    minimumSize: Size(isSmallScreen ? 100 : 120, isSmallScreen ? 36 : 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    _isFollowing ? 'Following' : 'Follow',
                    style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                  ),
                ),
              ],
            ),
          ),
          // Posts Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: isSmallScreen ? 10 : 12,
              ),
              children: [
                Text(
                  'Posts',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: isSmallScreen ? 14 : 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 12),
                ..._userPosts.map((post) {
                  return ThreadCard(
                    id: post['id'] as int,
                    title: post['title'] as String,
                    content: post['content'] as String,
                    author: post['author'] as String,
                    avatar: post['avatar'] as String?,
                    time: post['time'] as String,
                    likes: post['likes'] as int,
                    comments: post['comments'] as int,
                    views: post['views'] as int,
                    isSmallScreen: isSmallScreen,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

