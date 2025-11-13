import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../contexts/dark_mode_context.dart';
import '../components/comment_input.dart';
import '../components/comment_card.dart';

class ThreadPage extends StatefulWidget {
  final String threadId;

  const ThreadPage({super.key, required this.threadId});

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  final Map<String, Map<String, dynamic>> _threadData = {
    '1': {
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
      'space': {'name': 'Computer Science', 'icon': '💻'},
    },
    '2': {
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
      'image':
          'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=800&auto=format&fit=crop',
      'space': {'name': 'Campus Events', 'icon': '🎉'},
    },
    '3': {
      'id': 3,
      'title': 'New Gaming Tournament',
      'content':
          'Sign ups are open for the annual gaming tournament! Prizes include gaming gear and gift cards.',
      'author': 'TechGuru',
      'avatar': '🦊',
      'time': '1d ago',
      'likes': 56,
      'comments': 23,
      'views': 312,
      'space': {'name': 'Gaming Club', 'icon': '🎮'},
    },
    '4': {
      'id': 4,
      'title': 'Photography Walk Next Week',
      'content':
          "Join us for a photo walk around campus. Bring your camera and let's capture some amazing shots!",
      'author': 'PhotoPro',
      'avatar': '📷',
      'time': '2d ago',
      'likes': 38,
      'comments': 11,
      'views': 167,
      'space': {'name': 'Photography', 'icon': '📸'},
    },
    '5': {
      'id': 5,
      'title': 'Study Materials Exchange',
      'content':
          'Looking to trade study materials for different courses. Have CS notes, need Math resources.',
      'author': 'CourseHunter',
      'avatar': '🤓',
      'time': '3d ago',
      'likes': 29,
      'comments': 18,
      'views': 145,
      'space': {'name': 'Study Groups', 'icon': '📚'},
    },
  };

  late Map<String, dynamic> _thread;
  late int _likes;
  bool _isLiked = false;

  final List<Map<String, dynamic>> _comments = [
    {
      'id': 1,
      'author': 'TechGuru',
      'avatar': '🦊',
      'content': 'I would love to join! What subjects are you focusing on?',
      'time': '1h ago',
      'likes': 5,
    },
    {
      'id': 2,
      'author': 'CourseHunter',
      'avatar': '🤓',
      'content': 'Count me in! I need help with algorithms.',
      'time': '45m ago',
      'likes': 3,
    },
    {
      'id': 3,
      'author': 'BookWorm',
      'avatar': '🐼',
      'content': 'This sounds great! Where should we meet?',
      'time': '30m ago',
      'likes': 2,
    },
  ];

  @override
  void initState() {
    super.initState();
    _thread = _threadData[widget.threadId] ??
        {
          'id': int.tryParse(widget.threadId) ?? 1,
          'title': 'Thread Title',
          'content': 'Thread content goes here...',
          'author': 'User',
          'avatar': '😊',
          'time': '1h ago',
          'likes': 0,
          'comments': 0,
          'views': 0,
        };
    _likes = _thread['likes'] as int;
  }

  void _handleLike() {
    setState(() {
      if (_isLiked) {
        _likes--;
      } else {
        _likes++;
      }
      _isLiked = !_isLiked;
    });
  }

  void _handleAddComment(String comment) {
    setState(() {
      final newComment = {
        'id': _comments.length + 1,
        'author': 'You',
        'avatar': '😊',
        'content': comment,
        'time': 'Just now',
        'likes': 0,
      };
      _comments.add(newComment);
    });
  }

  void _handleReply(int commentId, String reply) {
    setState(() {
      final newComment = {
        'id': _comments.length + 1,
        'author': 'You',
        'avatar': '😊',
        'content': reply,
        'time': 'Just now',
        'likes': 0,
      };
      _comments.add(newComment);
    });
  }

  void _handleShare() {
    // Share functionality
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return Scaffold(
      backgroundColor: darkMode.isDarkMode
          ? const Color(0xFF1A1A1A)
          : Colors.white,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: darkMode.isDarkMode
                  ? const Color(0xFF1A1A1A)
                  : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: darkMode.isDarkMode
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFF3F4F6),
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: darkMode.isDarkMode
                        ? Colors.white
                        : const Color(0xFF111827),
                  ),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/home');
                    }
                  },
                ),
                Text(
                  'Thread',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: darkMode.isDarkMode
                        ? Colors.white
                        : const Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _thread['avatar'] as String,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _thread['author'] as String,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: darkMode.isDarkMode
                                                ? Colors.white
                                                : const Color(0xFF111827),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (_thread['space'] != null) ...[
                                        const SizedBox(width: 4),
                                        Text(
                                          'in',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: darkMode.isDarkMode
                                                ? const Color(0xFF999999)
                                                : const Color(0xFF9CA3AF),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF8B4513)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  (_thread['space']
                                                      as Map)['icon'] as String,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(width: 2),
                                                Flexible(
                                                  child: Text(
                                                    (_thread['space']
                                                        as Map)['name'] as String,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color(0xFF8B4513),
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    _thread['time'] as String,
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
                        const SizedBox(height: 12),
                        Text(
                          _thread['title'] as String,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkMode.isDarkMode
                                ? Colors.white
                                : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _thread['content'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: darkMode.isDarkMode
                                ? const Color(0xFF999999)
                                : const Color(0xFF374151),
                          ),
                        ),
                        if (_thread['image'] != null) ...[
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              _thread['image'] as String,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Divider(
                          color: darkMode.isDarkMode
                              ? const Color(0xFF2A2A2A)
                              : const Color(0xFFE5E7EB),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: _handleLike,
                                  child: Row(
                                    children: [
                                      Icon(
                                        _isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 18,
                                        color: _isLiked
                                            ? Colors.red
                                            : (darkMode.isDarkMode
                                                ? const Color(0xFF999999)
                                                : const Color(0xFF6B7280)),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '$_likes',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _isLiked
                                              ? Colors.red
                                              : (darkMode.isDarkMode
                                                  ? const Color(0xFF999999)
                                                  : const Color(0xFF6B7280)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.comment,
                                      size: 18,
                                      color: darkMode.isDarkMode
                                          ? const Color(0xFF999999)
                                          : const Color(0xFF6B7280),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${_comments.length}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: darkMode.isDarkMode
                                            ? const Color(0xFF999999)
                                            : const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 24),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      size: 18,
                                      color: darkMode.isDarkMode
                                          ? const Color(0xFF999999)
                                          : const Color(0xFF6B7280),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${_thread['views']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: darkMode.isDarkMode
                                            ? const Color(0xFF999999)
                                            : const Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.share,
                                color: darkMode.isDarkMode
                                    ? const Color(0xFF999999)
                                    : const Color(0xFF6B7280),
                              ),
                              onPressed: _handleShare,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comments (${_comments.length})',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: darkMode.isDarkMode
                                ? Colors.white
                                : const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CommentInput(
                          onSubmit: _handleAddComment,
                          placeholder: 'Write a comment...',
                        ),
                        const SizedBox(height: 16),
                        ..._comments.map((comment) {
                          return CommentCard(
                            id: comment['id'] as int,
                            author: comment['author'] as String,
                            avatar: comment['avatar'] as String,
                            content: comment['content'] as String,
                            time: comment['time'] as String,
                            likes: comment['likes'] as int,
                            onReply: _handleReply,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

