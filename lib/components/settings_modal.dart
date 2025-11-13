import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';

class SettingsModal extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final String currentAvatar;
  final String currentName;
  final String currentUsername;
  final String currentBio;
  final Function(String) onAvatarChange;
  final Function(String) onNameChange;
  final Function(String) onBioChange;
  final VoidCallback onLogout;

  const SettingsModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.currentAvatar,
    required this.currentName,
    required this.currentUsername,
    required this.currentBio,
    required this.onAvatarChange,
    required this.onNameChange,
    required this.onBioChange,
    required this.onLogout,
  });

  @override
  State<SettingsModal> createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late String _selectedAvatar;

  final List<String> _avatars = [
    '😊',
    '😎',
    '🤓',
    '😇',
    '🥳',
    '🤩',
    '😺',
    '🦊',
    '🐼',
    '🐨',
    '🦁',
    '🐯',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _bioController = TextEditingController(text: widget.currentBio);
    _selectedAvatar = widget.currentAvatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _handleSave() {
    widget.onAvatarChange(_selectedAvatar);
    widget.onNameChange(_nameController.text);
    widget.onBioChange(_bioController.text);
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) return const SizedBox.shrink();

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
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B4513),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Avatar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _avatars.length,
                itemBuilder: (context, index) {
                  final avatar = _avatars[index];
                  final isSelected = _selectedAvatar == avatar;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = avatar;
                      });
                    },
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8B4513)
                            : darkMode.isDarkMode
                                ? const Color(0xFF1A1A1A)
                                : const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: const Color(0xFF8B4513).withOpacity(0.3),
                                width: 4,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          avatar,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: darkMode.isDarkMode
                      ? const Color(0xFF1A1A1A)
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ),
                style: TextStyle(
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bio',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _bioController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tell us about yourself...',
                  filled: true,
                  fillColor: darkMode.isDarkMode
                      ? const Color(0xFF1A1A1A)
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF8B4513),
                    ),
                  ),
                ),
                style: TextStyle(
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onClose,
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B4513),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

