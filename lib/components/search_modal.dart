import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchModal extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;

  const SearchModal({
    super.key,
    required this.isOpen,
    required this.onClose,
  });

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _spaces = [
    {
      'id': 1,
      'title': 'Computer Science',
      'description': 'For all CS majors and enthusiasts',
      'iconLetter': '💻',
      'memberCount': 342,
    },
    {
      'id': 2,
      'title': 'Business School',
      'description': 'Discussions on business trends and courses',
      'iconLetter': '💼',
      'memberCount': 215,
    },
    {
      'id': 3,
      'title': 'Arts & Humanities',
      'description': 'Share creative works and discuss literature',
      'iconLetter': '🎨',
      'memberCount': 189,
    },
    {
      'id': 4,
      'title': 'Engineering',
      'description': 'Projects, internships, and course help',
      'iconLetter': '⚙️',
      'memberCount': 428,
    },
    {
      'id': 5,
      'title': 'Campus Events',
      'description': 'Upcoming events and activities on campus',
      'iconLetter': '🎉',
      'memberCount': 567,
    },
    {
      'id': 6,
      'title': 'Study Groups',
      'description': 'Find study partners for any course',
      'iconLetter': '📚',
      'memberCount': 391,
    },
  ];

  final List<Map<String, dynamic>> _users = [
    {
      'id': 1,
      'username': 'StudyBuddy',
      'bio': 'CS major, love coding and coffee',
      'avatar': '😊',
    },
    {
      'id': 2,
      'username': 'EventPlanner',
      'bio': 'Organizing campus events since 2020',
      'avatar': '😎',
    },
    {
      'id': 3,
      'username': 'CourseHunter',
      'bio': 'Always looking for the best professors',
      'avatar': '🤓',
    },
    {
      'id': 4,
      'username': 'BookWorm',
      'bio': 'Literature enthusiast and library regular',
      'avatar': '🐼',
    },
    {
      'id': 5,
      'username': 'TechGuru',
      'bio': 'Software engineering and AI research',
      'avatar': '🦊',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredSpaces {
    if (_searchController.text.isEmpty) return [];
    final query = _searchController.text.toLowerCase();
    return _spaces.where((space) {
      return space['title'].toString().toLowerCase().contains(query) ||
          space['description'].toString().toLowerCase().contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredUsers {
    if (_searchController.text.isEmpty) return [];
    final query = _searchController.text.toLowerCase();
    return _users.where((user) {
      return user['username'].toString().toLowerCase().contains(query) ||
          user['bio'].toString().toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) return const SizedBox.shrink();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1F2937);
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280);
    final borderColor = isDarkMode ? const Color(0xFF404040) : const Color(0xFFE5E7EB);

    return Material(
      color: backgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(
                bottom: BorderSide(color: borderColor),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: widget.onClose,
                  color: textColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search spaces and users...',
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryTextColor,
                        fontWeight: FontWeight.normal,
                      ),
                      prefixIcon: Icon(Icons.search, color: secondaryTextColor),
                      filled: true,
                      fillColor: isDarkMode ? const Color(0xFF2D2D2D) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchController.text.trim().isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 48,
                          color: secondaryTextColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for spaces and users to get started',
                          style: GoogleFonts.poppins(
                            color: secondaryTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_filteredSpaces.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 4.0),
                            child: Text(
                              'Spaces',
                              style: GoogleFonts.poppins(
                                color: secondaryTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._filteredSpaces.map((space) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isDarkMode ? const Color(0xFF404040) : const Color(0xFFF3F4F6),
                                child: Text(
                                  space['iconLetter'],
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                              title: Text(
                                space['title'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                '${space['memberCount']} members',
                                style: GoogleFonts.poppins(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                // Handle space selection
                              },
                            );
                          }),
                          const SizedBox(height: 24),
                        ],
                        if (_filteredUsers.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, top: 16.0, left: 4.0),
                            child: Text(
                              'Users',
                              style: GoogleFonts.poppins(
                                color: secondaryTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._filteredUsers.map((user) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isDarkMode ? const Color(0xFF404040) : const Color(0xFFF3F4F6),
                                child: Text(
                                  user['avatar'],
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                              title: Text(
                                user['username'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                user['bio'],
                                style: GoogleFonts.poppins(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onTap: () {
                                // Handle user selection
                              },
                            );
                          }),
                        ],
                        if (_filteredSpaces.isEmpty &&
                            _filteredUsers.isEmpty) ...[
                          Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.search_off,
                                  size: 48,
                                  color: Color(0xFF9CA3AF),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'No results found',
                                  style: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

