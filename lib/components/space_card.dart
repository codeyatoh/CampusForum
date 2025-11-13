import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../contexts/dark_mode_context.dart';

class SpaceCard extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String iconLetter;
  final int memberCount;

  const SpaceCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.iconLetter,
    this.memberCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return InkWell(
      onTap: () {
        context.push('/space/$id');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: darkMode.isDarkMode
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF3F4F6),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF8B4513),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  iconLetter,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkMode.isDarkMode
                          ? Colors.white
                          : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: darkMode.isDarkMode
                          ? const Color(0xFF999999)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: darkMode.isDarkMode
                      ? const Color(0xFF999999)
                      : const Color(0xFF6B7280),
                ),
                const SizedBox(width: 4),
                Text(
                  '$memberCount',
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
      ),
    );
  }
}

