import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/bottom_navigation.dart';
import '../components/space_card.dart';
import '../components/create_space_modal.dart';
import '../theme/app_theme.dart';

class SpacesPage extends StatefulWidget {
  const SpacesPage({super.key});

  @override
  State<SpacesPage> createState() => _SpacesPageState();
}

class _SpacesPageState extends State<SpacesPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showCreateSpace = false;

  final List<Map<String, dynamic>> _spaces = [
    {
      'id': 1,
      'title': 'Computer Science',
      'description': 'For all CS majors and enthusiasts',
      'iconLetter': '💻',
      'memberCount': 342,
      'isOwner': false,
    },
    {
      'id': 2,
      'title': 'Business School',
      'description': 'Discussions on business trends and courses',
      'iconLetter': '💼',
      'memberCount': 215,
      'isOwner': false,
    },
    {
      'id': 3,
      'title': 'Gaming Club',
      'description': 'Gaming tournaments and discussions',
      'iconLetter': '🎮',
      'memberCount': 156,
      'isOwner': true,
    },
    {
      'id': 4,
      'title': 'Photography',
      'description': 'Share and discuss photography',
      'iconLetter': '📸',
      'memberCount': 89,
      'isOwner': true,
    },
    {
      'id': 5,
      'title': 'Arts & Humanities',
      'description': 'Share creative works and discuss literature',
      'iconLetter': '🎨',
      'memberCount': 189,
      'isOwner': false,
    },
    {
      'id': 6,
      'title': 'Engineering',
      'description': 'Projects, internships, and course help',
      'iconLetter': '⚙️',
      'memberCount': 428,
      'isOwner': false,
    },
    {
      'id': 7,
      'title': 'Campus Events',
      'description': 'Upcoming events and activities on campus',
      'iconLetter': '🎉',
      'memberCount': 567,
      'isOwner': false,
    },
    {
      'id': 8,
      'title': 'Study Groups',
      'description': 'Find study partners for any course',
      'iconLetter': '📚',
      'memberCount': 391,
      'isOwner': false,
    },
  ];

  void _handleCreateSpace(Map<String, String> newSpace) {
    setState(() {
      final space = {
        'id': _spaces.length + 1,
        ...newSpace,
        'memberCount': 1,
        'isOwner': true,
      };
      _spaces.insert(0, space);
    });
  }

  List<Map<String, dynamic>> get _filteredSpaces {
    if (_searchController.text.isEmpty) return _spaces;
    final query = _searchController.text.toLowerCase();
    return _spaces.where((space) {
      return space['title'].toString().toLowerCase().contains(query) ||
          space['description'].toString().toLowerCase().contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get _yourCreatedSpaces {
    return _filteredSpaces.where((space) => space['isOwner'] == true).toList();
  }

  List<Map<String, dynamic>> get _generalSpaces {
    return _filteredSpaces.where((space) => space['isOwner'] == false).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppTheme.darkBackground : AppTheme.lightBackground;
    final surfaceColor = isDarkMode ? AppTheme.darkSurface : AppTheme.lightSurface;
    final textColor = isDarkMode ? AppTheme.darkText : AppTheme.lightText;
    final secondaryTextColor = isDarkMode ? AppTheme.darkSecondaryText : AppTheme.lightSecondaryText;
    final borderColor = isDarkMode ? AppTheme.darkBorder : AppTheme.lightBorder;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spaces',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Search spaces...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: secondaryTextColor,
                              ),
                              filled: true,
                              fillColor: surfaceColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: borderColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: borderColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF8B4513),
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showCreateSpace = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    if (_yourCreatedSpaces.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Your Created Spaces',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                      ..._yourCreatedSpaces.map((space) {
                        return SpaceCard(
                          id: space['id'] as int,
                          title: space['title'] as String,
                          description: space['description'] as String,
                          iconLetter: space['iconLetter'] as String,
                          memberCount: space['memberCount'] as int,
                        );
                      }),
                    ],
                    if (_generalSpaces.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'General Spaces',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                      ..._generalSpaces.map((space) {
                        return SpaceCard(
                          id: space['id'] as int,
                          title: space['title'] as String,
                          description: space['description'] as String,
                          iconLetter: space['iconLetter'] as String,
                          memberCount: space['memberCount'] as int,
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ],
          ),
          CreateSpaceModal(
            isOpen: _showCreateSpace,
            onClose: () {
              setState(() {
                _showCreateSpace = false;
              });
            },
            onSubmit: _handleCreateSpace,
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

