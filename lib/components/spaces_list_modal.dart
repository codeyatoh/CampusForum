import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../contexts/dark_mode_context.dart';

class SpacesListModal extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final List<Map<String, dynamic>> spaces;

  const SpacesListModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.spaces,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox.shrink();

    final darkMode = Provider.of<DarkModeProvider>(context);

    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: darkMode.isDarkMode
                ? const Color(0xFF2A2A2A)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Spaces',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B4513),
                ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: spaces.length,
                  itemBuilder: (context, index) {
                    final space = spaces[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          context.push('/space/${space['id']}');
                          onClose();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: darkMode.isDarkMode
                                ? const Color(0xFF1A1A1A)
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(12),
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
                                    space['iconLetter'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      space['title'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: darkMode.isDarkMode
                                            ? Colors.white
                                            : const Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 12,
                                          color: darkMode.isDarkMode
                                              ? const Color(0xFF999999)
                                              : const Color(0xFF6B7280),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${space['memberCount'] ?? 0}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: darkMode.isDarkMode
                                                ? const Color(0xFF999999)
                                                : const Color(0xFF6B7280),
                                          ),
                                        ),
                                        if (space['isOwner'] == true) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF8B4513),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Text(
                                              'Owner',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onClose,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: BorderSide(
                      color: darkMode.isDarkMode
                          ? Colors.white
                          : const Color(0xFFD1D5DB),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: darkMode.isDarkMode
                          ? Colors.white
                          : const Color(0xFF111827),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

