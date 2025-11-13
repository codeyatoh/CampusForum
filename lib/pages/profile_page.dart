import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../contexts/dark_mode_context.dart';
import '../components/bottom_navigation.dart';
import '../components/thread_card.dart';
import '../components/settings_modal.dart';
import '../components/spaces_list_modal.dart';
import '../theme/app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showSettings = false;
  bool _showAllSpaces = false;
  String _avatar = '😊';
  String _name = 'Rea Mae';
  final String _username = '_reamae';
  String _bio = 'Student at Campus University | Passionate learner 📚';

  final List<Map<String, dynamic>> _mySpaces = [
    {
      'id': 1,
      'title': 'Computer Science',
      'iconLetter': '💻',
      'memberCount': 342,
      'isOwner': false,
    },
    {
      'id': 2,
      'title': 'Study Groups',
      'iconLetter': '📚',
      'memberCount': 391,
      'isOwner': false,
    },
    {
      'id': 3,
      'title': 'Gaming Club',
      'iconLetter': '🎮',
      'memberCount': 156,
      'isOwner': true,
    },
    {
      'id': 4,
      'title': 'Photography',
      'iconLetter': '📸',
      'memberCount': 89,
      'isOwner': true,
    },
  ];

  final List<Map<String, dynamic>> _userPosts = [
    {
      'id': 1,
      'title': 'My First Post',
      'content':
          'Just joined CampusForum! Excited to connect with everyone.',
      'author': 'You',
      'time': '1d ago',
      'likes': 15,
      'comments': 5,
      'views': 89,
    },
    {
      'id': 2,
      'title': 'Study Tips for Finals',
      'content': 'Here are some strategies that helped me ace my exams...',
      'author': 'You',
      'time': '3d ago',
      'likes': 32,
      'comments': 12,
      'views': 156,
    },
  ];

  void _handleLogout() {
    context.go('/');
  }

  void _handleSpaceClick(int spaceId) {
    context.push('/space/$spaceId');
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground;
    final surfaceColor = isDarkMode ? AppTheme.darkSurface : AppTheme.lightSurface;
    final textColor = isDarkMode ? AppTheme.darkText : AppTheme.lightText;
    final secondaryTextColor = isDarkMode ? AppTheme.darkSecondaryText : AppTheme.lightSecondaryText;
    
    // Get screen dimensions for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    final displayedSpaces = _mySpaces.take(4).toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 16,
                    vertical: isSmallScreen ? 10 : 12,
                  ),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
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
                          _avatar,
                            style: TextStyle(fontSize: isSmallScreen ? 28 : 32),
                          ),
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 10 : 12),
                    Text(
                      _name,
                      style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                        overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '@$_username',
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
                      _bio,
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
                              '124',
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
                              '89',
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
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _showSettings = true;
                        });
                      },
                        icon: Icon(Icons.settings, size: isSmallScreen ? 14 : 16),
                        label: Text('Edit Profile', style: TextStyle(fontSize: isSmallScreen ? 13 : 14)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B4513),
                        foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 16 : 20,
                            vertical: isSmallScreen ? 8 : 10,
                        ),
                          minimumSize: Size(isSmallScreen ? 100 : 120, isSmallScreen ? 36 : 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF1F2937)
                          : const Color(0xFFF3F4F6),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Spaces',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isSmallScreen ? 14 : 16,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...displayedSpaces.map((space) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: InkWell(
                                onTap: () => _handleSpaceClick(space['id']),
                                child: Column(
                                  children: [
                                    Container(
                                      width: isSmallScreen ? 44 : 48,
                                      height: isSmallScreen ? 44 : 48,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF8B4513),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          space['iconLetter'],
                                          style: TextStyle(fontSize: isSmallScreen ? 18 : 20),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    SizedBox(
                                      width: isSmallScreen ? 56 : 60,
                                      child: Text(
                                        space['title'],
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 11 : 12,
                                          color: darkMode.isDarkMode
                                              ? const Color(0xFF999999)
                                              : const Color(0xFF6B7280),
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _showAllSpaces = true;
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: darkMode.isDarkMode
                                        ? const Color(0xFF2A2A2A)
                                        : const Color(0xFFE5E7EB),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: darkMode.isDarkMode
                                        ? const Color(0xFF999999)
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'See More',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: darkMode.isDarkMode
                                        ? const Color(0xFF999999)
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 16,
                    vertical: isSmallScreen ? 10 : 12,
                  ),
                  children: [
                    Text(
                      'My Posts',
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
                        time: post['time'] as String,
                        likes: post['likes'] as int,
                        comments: post['comments'] as int,
                        views: post['views'] as int,
                        isOwner: true,
                        isSmallScreen: isSmallScreen,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
          SettingsModal(
            isOpen: _showSettings,
            onClose: () {
              setState(() {
                _showSettings = false;
              });
            },
            currentAvatar: _avatar,
            currentName: _name,
            currentUsername: _username,
            currentBio: _bio,
            onAvatarChange: (avatar) {
              setState(() {
                _avatar = avatar;
              });
            },
            onNameChange: (name) {
              setState(() {
                _name = name;
              });
            },
            onBioChange: (bio) {
              setState(() {
                _bio = bio;
              });
            },
            onLogout: _handleLogout,
          ),
          SpacesListModal(
            isOpen: _showAllSpaces,
            onClose: () {
              setState(() {
                _showAllSpaces = false;
              });
            },
            spaces: _mySpaces,
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

