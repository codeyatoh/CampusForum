import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../contexts/dark_mode_context.dart';

class BottomNavigation extends StatelessWidget {
  final VoidCallback? onAddPost;

  const BottomNavigation({super.key, this.onAddPost});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);
    final currentRoute = GoRouterState.of(context).uri.path;

    final navItems = [
      {
        'icon': Icons.home,
        'path': '/home',
        'label': 'Home',
      },
      {
        'icon': Icons.grid_view,
        'path': '/spaces',
        'label': 'Spaces',
      },
      {
        'icon': Icons.notifications,
        'path': '/notifications',
        'label': 'Alerts',
      },
      {
        'icon': Icons.person,
        'path': '/profile',
        'label': 'Profile',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: darkMode.isDarkMode
            ? const Color(0xFF1A1A1A)
            : Colors.white,
        border: Border(
          top: BorderSide(
            color: darkMode.isDarkMode
                ? const Color(0xFF2A2A2A)
                : const Color(0xFFE5E5E5),
          ),
        ),
      ),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems.map((item) {
          final isActive = currentRoute == item['path'];
          return InkWell(
            onTap: () {
              if (item['path'] != null) {
                context.go(item['path'] as String);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item['icon'] as IconData,
                  size: 24,
                  color: isActive
                      ? const Color(0xFF8B4513)
                      : darkMode.isDarkMode
                          ? const Color(0xFF999999)
                          : const Color(0xFF9CA3AF),
                ),
                const SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive
                        ? const Color(0xFF8B4513)
                        : darkMode.isDarkMode
                            ? const Color(0xFF999999)
                            : const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

