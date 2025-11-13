import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';
import '../components/bottom_navigation.dart';
import '../components/thread_card.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    final followedThreads = [
      {
        'id': 1,
        'title': 'New CS Course Announced',
        'content':
            'The CS department just announced a new AI course for next semester. Registration opens next week!',
        'author': 'CSMajor',
        'time': '3h ago',
        'likes': 56,
        'comments': 23,
        'views': 234,
      },
      {
        'id': 2,
        'title': 'Library Hours Extended',
        'content':
            'The main library will be open 24/7 during finals week. Coffee and snacks provided!',
        'author': 'BookWorm',
        'time': '1d ago',
        'likes': 88,
        'comments': 12,
        'views': 345,
        'image':
            'https://uploadthingy.s3.us-west-1.amazonaws.com/1S4YrwRTsWaxNRrtH2umL2/pasted-image.jpg',
      },
    ];

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: darkMode.isDarkMode
                          ? Colors.white
                          : const Color(0xFF111827),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: darkMode.isDarkMode
                        ? const Color(0xFF999999)
                        : const Color(0xFF374151),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: followedThreads.map((thread) {
                return ThreadCard(
                  id: thread['id'] as int,
                  title: thread['title'] as String,
                  content: thread['content'] as String,
                  author: thread['author'] as String,
                  time: thread['time'] as String,
                  likes: thread['likes'] as int,
                  comments: thread['comments'] as int,
                  views: thread['views'] as int,
                  image: thread['image'] as String?,
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

