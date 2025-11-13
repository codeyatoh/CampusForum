import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';

class CreateSpaceModal extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final Function(Map<String, String>) onSubmit;

  const CreateSpaceModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  State<CreateSpaceModal> createState() => _CreateSpaceModalState();
}

class _CreateSpaceModalState extends State<CreateSpaceModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedIcon = '';

  final List<String> _emojiOptions = [
    '💻',
    '💼',
    '🎨',
    '⚙️',
    '🎉',
    '📚',
    '🎓',
    '⚽',
    '🎵',
    '🍕',
    '🏠',
    '✈️',
    '🎮',
    '📱',
    '🌟',
    '🔬',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() && _selectedIcon.isNotEmpty) {
      widget.onSubmit({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'iconLetter': _selectedIcon,
      });
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedIcon = '';
      });
      widget.onClose();
    }
  }

  void _handleCancel() {
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedIcon = '';
    });
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create New Space',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Space Icon',
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
                    crossAxisCount: 8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _emojiOptions.length,
                  itemBuilder: (context, index) {
                    final emoji = _emojiOptions[index];
                    final isSelected = _selectedIcon == emoji;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIcon = emoji;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (darkMode.isDarkMode
                                  ? const Color(0xFF8B4513)
                                  : const Color(0xFF8B4513))
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
                            emoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Space Name',
                    hintText: 'Enter space name...',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a space name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'What is this space about?',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _handleCancel,
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
                          'Cancel',
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
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B4513),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Create Space',
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
      ),
    );
  }
}

