import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/bottom_navigation.dart';
import '../components/thread_card.dart';
import '../components/edit_space_modal.dart';
import '../components/delete_space_modal.dart';
import '../components/quick_post_composer.dart';
import '../components/edit_post_modal.dart';
import '../theme/app_theme.dart';

class SpaceProfilePage extends StatefulWidget {
  final String spaceId;

  const SpaceProfilePage({super.key, required this.spaceId});

  @override
  State<SpaceProfilePage> createState() => _SpaceProfilePageState();
}

class _SpaceProfilePageState extends State<SpaceProfilePage> {
  bool _showEditSpace = false;
  bool _showDeleteSpace = false;
  bool _showEditPost = false;
  bool _isNotificationEnabled = false;
  Map<String, dynamic>? _editingPost;

  final Map<String, Map<String, dynamic>> _spaceData = {
    '1': {
      'id': 1,
      'title': 'Computer Science',
      'description': 'For all CS majors and enthusiasts',
      'iconLetter': '💻',
      'memberCount': 342,
      'isOwner': false,
      'isMember': true,
    },
    '2': {
      'id': 2,
      'title': 'Study Groups',
      'description': 'Find study partners for any course',
      'iconLetter': '📚',
      'memberCount': 391,
      'isOwner': false,
      'isMember': true,
    },
    '3': {
      'id': 3,
      'title': 'Gaming Club',
      'description': 'Gaming tournaments and discussions',
      'iconLetter': '🎮',
      'memberCount': 156,
      'isOwner': true,
      'isMember': true,
    },
    '4': {
      'id': 4,
      'title': 'Photography',
      'description': 'Share and discuss photography',
      'iconLetter': '📸',
      'memberCount': 89,
      'isOwner': true,
      'isMember': true,
    },
  };

  late Map<String, dynamic> _space;

  final Map<String, List<Map<String, dynamic>>> _initialPostsBySpace = {
    '1': [
      {
        'id': 1,
        'title': 'Study Group for Finals',
        'content':
            'Looking for people to study with for the upcoming finals. Anyone interested in joining?',
        'author': 'StudyBuddy',
        'avatar': '😊',
        'time': '2h ago',
        'likes': 24,
        'comments': 8,
        'views': 156,
        'category': 'Study Groups',
      },
      {
        'id': 2,
        'title': 'Python Workshop This Saturday',
        'content':
            'Free Python programming workshop for beginners. Bring your laptop and learn the basics!',
        'author': 'TechGuru',
        'avatar': '🦊',
        'time': '4d ago',
        'likes': 67,
        'comments': 34,
        'views': 289,
        'category': 'Technology',
      },
    ],
    '3': [
      {
        'id': 4,
        'title': 'New Gaming Tournament',
        'content':
            'Sign ups are open for the annual gaming tournament! Prizes include gaming gear and gift cards.',
        'author': 'TechGuru',
        'avatar': '🦊',
        'time': '1d ago',
        'likes': 56,
        'comments': 23,
        'views': 312,
        'category': 'Events',
      },
    ],
    '4': [
      {
        'id': 5,
        'title': 'Photography Walk Next Week',
        'content':
            "Join us for a photo walk around campus. Bring your camera and let's capture some amazing shots!",
        'author': 'PhotoPro',
        'avatar': '📷',
        'time': '2d ago',
        'likes': 38,
        'comments': 11,
        'views': 167,
        'category': 'Arts & Culture',
      },
    ],
  };

  late List<Map<String, dynamic>> _spacePosts;

  @override
  void initState() {
    super.initState();
    _space = _spaceData[widget.spaceId] ??
        {
          'id': int.tryParse(widget.spaceId) ?? 1,
          'title': 'New Space',
          'description': 'A new community space',
          'iconLetter': '🌟',
          'memberCount': 1,
          'isOwner': false,
          'isMember': false,
        };
    _spacePosts = _initialPostsBySpace[widget.spaceId] ?? [];
  }

  void _handleJoinLeave() {
    setState(() {
      _space['isMember'] = !_space['isMember'];
      _space['memberCount'] = _space['isMember']
          ? (_space['memberCount'] as int) + 1
          : (_space['memberCount'] as int) - 1;
    });
  }

  void _handleUpdateSpace(Map<String, String> updatedSpace) {
    setState(() {
      _space = {..._space, ...updatedSpace};
    });
  }

  void _handleCreatePost(Map<String, dynamic> newPost) {
    setState(() {
      final post = {
        'id': DateTime.now().millisecondsSinceEpoch,
        ...newPost,
        'author': 'You',
        'avatar': '😊',
        'time': 'Just now',
        'likes': 0,
        'comments': 0,
        'views': 0,
        'space': {
          'name': _space['title'],
          'icon': _space['iconLetter'],
        },
      };
      _spacePosts.insert(0, post);
    });
  }

  void _handleEditPost(int id) {
    final post = _spacePosts.firstWhere((p) => p['id'] == id);
    setState(() {
      _editingPost = post;
      _showEditPost = true;
    });
  }

  void _handleUpdatePost(int id, Map<String, dynamic> updatedPost) {
    setState(() {
      final index = _spacePosts.indexWhere((post) => post['id'] == id);
      if (index != -1) {
        _spacePosts[index] = {..._spacePosts[index], ...updatedPost};
      }
    });
  }

  void _handleDeletePost(int id) {
    setState(() {
      _spacePosts.removeWhere((post) => post['id'] == id);
    });
  }

  void _handleDeleteSpace() {
    context.go('/spaces');
  }

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
      body: Stack(
        children: [
          Column(
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
                            context.go('/spaces');
                          }
                        },
                      ),
                      Expanded(
                        child: Text(
                          _space['title'] as String,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_space['isOwner'] == true)
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: secondaryTextColor,
                            size: isSmallScreen ? 20 : 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _showDeleteSpace = true;
                            });
                          },
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
                          _space['iconLetter'] as String,
                          style: TextStyle(fontSize: isSmallScreen ? 28 : 32),
                        ),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 12),
                    Text(
                      _space['title'] as String,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16),
                      child: Text(
                        _space['description'] as String,
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
                        Icon(
                          Icons.people,
                          size: isSmallScreen ? 14 : 16,
                          color: secondaryTextColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${_space['memberCount']} members',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 10 : 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_space['isOwner'] == true)
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showEditSpace = true;
                              });
                            },
                            icon: Icon(Icons.settings, size: isSmallScreen ? 14 : 16),
                            label: Text('Edit Space', style: TextStyle(fontSize: isSmallScreen ? 13 : 14)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B4513),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 20 : 24,
                                vertical: isSmallScreen ? 10 : 12,
                              ),
                              minimumSize: Size(isSmallScreen ? 100 : 120, isSmallScreen ? 36 : 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          )
                        else
                          ElevatedButton(
                            onPressed: _handleJoinLeave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _space['isMember'] == true
                                  ? Colors.white
                                  : const Color(0xFF8B4513),
                              foregroundColor: _space['isMember'] == true
                                  ? const Color(0xFF8B4513)
                                  : Colors.white,
                              side: _space['isMember'] == true
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
                              _space['isMember'] == true ? 'Leave Space' : 'Join Space',
                              style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                            ),
                          ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isNotificationEnabled = !_isNotificationEnabled;
                            });
                          },
                          icon: Icon(
                            Icons.notifications,
                            color: _isNotificationEnabled
                                ? const Color(0xFF8B4513)
                                : secondaryTextColor,
                            size: isSmallScreen ? 20 : 24,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: _isNotificationEnabled
                                ? const Color(0xFF8B4513).withOpacity(0.1)
                                : surfaceColor,
                          ),
                        ),
                      ],
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
                    QuickPostComposer(
                      onSubmit: _handleCreatePost,
                      userAvatar: '😊',
                      isSmallScreen: isSmallScreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Posts',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isSmallScreen ? 14 : 16,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_spacePosts.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            'No posts yet. Be the first to post in this space!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 12 : 14,
                              color: secondaryTextColor,
                            ),
                          ),
                        ),
                      )
                    else
                      ..._spacePosts.map((post) {
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
                          image: post['image'] as String?,
                          isOwner: post['author'] == 'You',
                          onEdit: _handleEditPost,
                          onDelete: _handleDeletePost,
                          space: {
                            'name': _space['title'] as String,
                            'icon': _space['iconLetter'] as String,
                          },
                          isSmallScreen: isSmallScreen,
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),
          EditSpaceModal(
            isOpen: _showEditSpace,
            onClose: () {
              setState(() {
                _showEditSpace = false;
              });
            },
            space: {
              'title': _space['title'] as String,
              'description': _space['description'] as String,
              'iconLetter': _space['iconLetter'] as String,
            },
            onSubmit: _handleUpdateSpace,
          ),
          DeleteSpaceModal(
            isOpen: _showDeleteSpace,
            onClose: () {
              setState(() {
                _showDeleteSpace = false;
              });
            },
            onConfirm: _handleDeleteSpace,
            spaceName: _space['title'] as String,
          ),
          if (_editingPost != null)
            EditPostModal(
              isOpen: _showEditPost,
              onClose: () {
                setState(() {
                  _showEditPost = false;
                  _editingPost = null;
                });
              },
              post: _editingPost!,
              onSubmit: _handleUpdatePost,
            ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
