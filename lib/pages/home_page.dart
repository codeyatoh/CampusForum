import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/bottom_navigation.dart';
import '../components/thread_card.dart';
import '../components/category_chips.dart';
import '../components/edit_post_modal.dart';
import '../components/filter_modal.dart';
import '../components/quick_post_composer.dart';
import '../components/search_modal.dart';
import '../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showEditPost = false;
  bool _showFilter = false;
  bool _showSearch = false;
  Map<String, dynamic>? _editingPost;
  String _selectedCategory = 'All';
  final String _userAvatar = '😊';

  final List<Map<String, dynamic>> _threads = [
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
      'space': {'name': 'Computer Science', 'icon': '💻'},
    },
    {
      'id': 2,
      'title': 'Campus Event This Weekend',
      'content':
          "There's a big event happening this weekend at the main quad. Music, food, and fun activities!",
      'author': 'EventPlanner',
      'avatar': '😎',
      'time': '5h ago',
      'likes': 42,
      'comments': 15,
      'views': 234,
      'category': 'Events',
      'image':
          'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800&auto=format&fit=crop',
      'space': {'name': 'Campus Events', 'icon': '🎉'},
    },
    {
      'id': 3,
      'title': 'Professor Recommendations',
      'content':
          'Has anyone taken classes with Professor Johnson? Looking for feedback before registration.',
      'author': 'CourseHunter',
      'avatar': '🤓',
      'time': '1d ago',
      'likes': 18,
      'comments': 32,
      'views': 189,
      'category': 'Academics',
    },
    {
      'id': 4,
      'title': 'New Gaming Tournament Announced',
      'content':
          'Sign ups are open for the annual gaming tournament! Prizes include gaming gear and gift cards.',
      'author': 'TechGuru',
      'avatar': '🦊',
      'time': '1d ago',
      'likes': 56,
      'comments': 23,
      'views': 312,
      'category': 'Events',
      'space': {'name': 'Gaming Club', 'icon': '🎮'},
    },
    {
      'id': 5,
      'title': 'Book Club Meeting This Friday',
      'content':
          "We'll be discussing 'The Great Gatsby' this week. All literature lovers welcome!",
      'author': 'BookWorm',
      'avatar': '🐼',
      'time': '2d ago',
      'likes': 31,
      'comments': 12,
      'views': 145,
      'category': 'Arts & Culture',
      'space': {'name': 'Arts & Humanities', 'icon': '🎨'},
    },
    {
      'id': 6,
      'title': 'Looking for Roommate',
      'content':
          'Need a roommate for next semester. Clean, quiet, and close to campus. DM if interested!',
      'author': 'RoomSeeker',
      'avatar': '🏠',
      'time': '3d ago',
      'likes': 12,
      'comments': 18,
      'views': 92,
      'category': 'Housing',
    },
    {
      'id': 7,
      'title': 'Best Coffee Spots Near Campus',
      'content':
          'Just discovered this amazing cafe near the library. Perfect for studying with great wifi!',
      'author': 'CoffeeLover',
      'avatar': '☕',
      'time': '3d ago',
      'likes': 45,
      'comments': 27,
      'views': 178,
      'category': 'Food & Dining',
      'image':
          'https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800&auto=format&fit=crop',
    },
    {
      'id': 8,
      'title': 'Python Workshop This Saturday',
      'content':
          'Free Python programming workshop for beginners. Bring your laptop and learn the basics!',
      'author': 'StudyBuddy',
      'avatar': '😊',
      'time': '4d ago',
      'likes': 67,
      'comments': 34,
      'views': 289,
      'category': 'Technology',
      'space': {'name': 'Computer Science', 'icon': '💻'},
    },
    {
      'id': 9,
      'title': 'Lost: Blue Backpack',
      'content':
          'Lost my blue backpack near the student center yesterday. Has my laptop and textbooks. Please contact if found!',
      'author': 'StudentInNeed',
      'avatar': '😰',
      'time': '5d ago',
      'likes': 8,
      'comments': 5,
      'views': 67,
      'category': 'Lost & Found',
    },
    {
      'id': 10,
      'title': 'Intramural Basketball Sign-ups',
      'content':
          'Join our intramural basketball team! No experience necessary, just bring your energy and team spirit.',
      'author': 'SportsEnthusiast',
      'avatar': '⛹️',
      'time': '5d ago',
      'likes': 38,
      'comments': 21,
      'views': 156,
      'category': 'Sports',
    },
    {
      'id': 11,
      'title': 'Web Development Study Session',
      'content':
          'Anyone want to join a study session for web development? Working on React and Node.js projects.',
      'author': 'TechGuru',
      'avatar': '🦊',
      'time': '6d ago',
      'likes': 29,
      'comments': 14,
      'views': 134,
      'category': 'Study Groups',
      'space': {'name': 'Computer Science', 'icon': '💻'},
    },
  ];

  final List<String> _categories = [
    'All',
    'Academics',
    'Study Groups',
    'Events',
    'Clubs',
    'Housing',
    'Food & Dining',
    'Sports',
    'Career & Jobs',
    'Campus Life',
    'Mental Health',
    'Technology',
    'Arts & Culture',
    'Travel',
    'Marketplace',
    'Lost & Found',
    'Random',
  ];

  void _handleCategorySelect(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _handleCreatePost(Map<String, dynamic> newPost) {
    setState(() {
      final post = {
        'id': _threads.length + 1,
        ...newPost,
        'author': 'You',
        'avatar': '😊',
        'time': 'Just now',
        'likes': 0,
        'comments': 0,
        'views': 0,
      };
      _threads.insert(0, post);
    });
  }

  void _handleEditPost(int id) {
    final post = _threads.firstWhere((t) => t['id'] == id);
    setState(() {
      _editingPost = post;
      _showEditPost = true;
    });
  }

  void _handleUpdatePost(int id, Map<String, dynamic> updatedPost) {
    setState(() {
      final index = _threads.indexWhere((thread) => thread['id'] == id);
      if (index != -1) {
        _threads[index] = {..._threads[index], ...updatedPost};
      }
    });
  }

  void _handleDeletePost(int id) {
    setState(() {
      _threads.removeWhere((thread) => thread['id'] == id);
    });
  }

  void _handleApplyFilters(Map<String, dynamic> filters) {
    // Handle filter application
  }

  List<Map<String, dynamic>> get _filteredThreads {
    if (_selectedCategory == 'All') return _threads;
    return _threads
        .where((thread) => thread['category'] == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground;
    final surfaceColor = isDarkMode ? AppTheme.darkSurface : AppTheme.lightSurface;
    final secondaryTextColor = isDarkMode ? AppTheme.darkSecondaryText : AppTheme.lightSecondaryText;
    
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375; // iPhone SE width

    // Handle modals first
    if (_showSearch) {
      return SearchModal(
        isOpen: _showSearch,
        onClose: () => setState(() => _showSearch = false),
      );
    }

    if (_editingPost != null) {
      return EditPostModal(
        isOpen: _showEditPost,
        onClose: () {
          setState(() {
            _showEditPost = false;
            _editingPost = null;
          });
        },
        post: _editingPost!,
        onSubmit: _handleUpdatePost,
      );
    }

    if (_showFilter) {
      return FilterModal(
        isOpen: _showFilter,
        onClose: () => setState(() => _showFilter = false),
        onApplyFilters: _handleApplyFilters,
      );
    }

    // Main content
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Header Section with SafeArea
          SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 12 : 16,
                vertical: isSmallScreen ? 8 : 12,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Row with Logo and Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'CampusForum',
                          style: GoogleFonts.caveatBrush(
                            fontSize: isSmallScreen ? 20 : 24,
                            color: const Color(0xFF8B4513),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              Icons.search, 
                              color: secondaryTextColor,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            onPressed: () => setState(() => _showSearch = true),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              Icons.settings, 
                              color: secondaryTextColor,
                              size: isSmallScreen ? 20 : 24,
                            ),
                            onPressed: () => context.go('/settings'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Content Section
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomScrollView(
                  slivers: [
                    // Category Chips and Post Composer
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16,
                          vertical: isSmallScreen ? 8 : 12,
                        ),
                        child: Column(
                          children: [
                            CategoryChips(
                              categories: _categories,
                              onSelectCategory: _handleCategorySelect,
                            ),
                            SizedBox(height: isSmallScreen ? 8 : 12),
                            QuickPostComposer(
                              onSubmit: _handleCreatePost,
                              userAvatar: _userAvatar,
                              isSmallScreen: isSmallScreen,
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                    
                    // Threads List
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 16,
                        vertical: 4,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final thread = _filteredThreads[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: 12,
                                left: isSmallScreen ? 4 : 0,
                                right: isSmallScreen ? 4 : 0,
                              ),
                              child: ThreadCard(
                                id: thread['id'] as int,
                                title: thread['title'] as String,
                                content: thread['content'] as String,
                                author: thread['author'] as String,
                                avatar: thread['avatar'] as String?,
                                time: thread['time'] as String,
                                likes: thread['likes'] as int,
                                comments: thread['comments'] as int,
                                views: thread['views'] as int,
                                image: thread['image'] as String?,
                                isOwner: thread['author'] == 'You',
                                onEdit: _handleEditPost,
                                onDelete: _handleDeletePost,
                                space: thread['space'] != null
                                    ? Map<String, String>.from(thread['space'] as Map<dynamic, dynamic>)
                                    : null,
                                isSmallScreen: isSmallScreen,
                              ),
                            );
                          },
                          childCount: _filteredThreads.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
