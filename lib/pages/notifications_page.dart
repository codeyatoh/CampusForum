import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../contexts/dark_mode_context.dart';
import '../components/bottom_navigation.dart';
import '../theme/app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground;
    final surfaceColor = isDarkMode ? AppTheme.darkSurface : AppTheme.lightSurface;
    final textColor = isDarkMode ? AppTheme.darkText : AppTheme.lightText;
    final secondaryTextColor = isDarkMode ? AppTheme.darkSecondaryText : AppTheme.lightSecondaryText;
    final borderColor = isDarkMode ? AppTheme.darkBorder : AppTheme.lightBorder;

    final notifications = [
      {
        'id': 1,
        'type': 'like',
        'user': 'StudyBuddy',
        'content': 'liked your post "Study Group for Finals"',
        'time': '2h ago',
        'read': false,
        'avatar': '😊',
      },
      {
        'id': 2,
        'type': 'comment',
        'user': 'EventPlanner',
        'content': 'commented on your post',
        'time': '5h ago',
        'read': false,
        'avatar': '😎',
      },
      {
        'id': 3,
        'type': 'follow',
        'user': 'CSMajor',
        'content': 'started following you',
        'time': '1d ago',
        'read': true,
        'avatar': '🤓',
      },
      {
        'id': 4,
        'type': 'like',
        'user': 'BookWorm',
        'content': 'liked your post "Library Hours Extended"',
        'time': '2d ago',
        'read': true,
        'avatar': '🐼',
      },
    ];

    IconData getIcon(String type) {
      switch (type) {
        case 'like':
          return Icons.favorite;
        case 'comment':
          return Icons.comment;
        case 'follow':
          return Icons.person_add;
        default:
          return Icons.notifications;
      }
    }

    Color getIconColor(String type) {
      switch (type) {
        case 'like':
          return Colors.red;
        case 'comment':
          return Colors.blue;
        case 'follow':
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Notifications',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final isRead = notification['read'] as bool;
                return InkWell(
                  onTap: () {
                    context.push('/user/${notification['user']}');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: !isRead
                          ? (darkMode.isDarkMode
                              ? const Color(0xFF1F2937)
                              : const Color(0xFFEFF6FF))
                          : null,
                      border: Border(
                        bottom: BorderSide(
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: darkMode.isDarkMode
                                  ? const Color(0xFF4B5563)
                                  : const Color(0xFFE5E7EB),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              notification['avatar'] as String,
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
                                    notification['user'] as String,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: darkMode.isDarkMode
                                          ? Colors.white
                                          : const Color(0xFF111827),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    getIcon(notification['type'] as String),
                                    size: 16,
                                    color: getIconColor(
                                      notification['type'] as String,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification['content'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode.isDarkMode
                                      ? const Color(0xFFD1D5DB)
                                      : const Color(0xFF4B5563),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification['time'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: darkMode.isDarkMode
                                      ? const Color(0xFF6B7280)
                                      : const Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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

