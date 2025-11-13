import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../contexts/dark_mode_context.dart';

class EditPostModal extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final Map<String, dynamic> post;
  final Function(int, Map<String, dynamic>) onSubmit;

  const EditPostModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.post,
    required this.onSubmit,
  });

  @override
  State<EditPostModal> createState() => _EditPostModalState();
}

class _EditPostModalState extends State<EditPostModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late String _selectedCategory;
  String? _previewUrl;

  final List<String> _categories = [
    'All',
    'Academics',
    'Study Groups',
    'Events',
    'Clubs',
    'Housing',
    'Food & Dining',
    'Sports',
    'Career & Jobs',
    'Campus Life',
    'Mental Health',
    'Technology',
    'Arts & Culture',
    'Travel',
    'Marketplace',
    'Lost & Found',
    'Random',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post['title'] ?? '');
    _contentController =
        TextEditingController(text: widget.post['content'] ?? '');
    _selectedCategory = widget.post['category'] ?? 'All';
    _previewUrl = widget.post['image'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _previewUrl = image.path;
      });
    }
  }

  void _handleRemoveFile() {
    setState(() {
      _previewUrl = null;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(widget.post['id'], {
        'title': _titleController.text,
        'content': _contentController.text,
        'category': _selectedCategory,
        'image': _previewUrl,
      });
      widget.onClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) return const SizedBox.shrink();

    final darkMode = Provider.of<DarkModeProvider>(context);
    final isVideo = _previewUrl != null && _previewUrl!.contains('video');

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
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit Post',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  const SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Category',
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
                    items: _categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Give your post a title...',
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
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _contentController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      hintText: "What's on your mind?",
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
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Media (optional)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: darkMode.isDarkMode
                          ? Colors.white
                          : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_previewUrl == null)
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _pickImage(ImageSource.gallery),
                            icon: const Icon(Icons.image),
                            label: const Text('Photo'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(
                                color: darkMode.isDarkMode
                                    ? const Color(0xFF2A2A2A)
                                    : const Color(0xFFE5E7EB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _pickImage(ImageSource.camera),
                            icon: const Icon(Icons.videocam),
                            label: const Text('Video'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(
                                color: darkMode.isDarkMode
                                    ? const Color(0xFF2A2A2A)
                                    : const Color(0xFFE5E7EB),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                              child: isVideo
                              ? const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: Icon(Icons.play_circle_filled,
                                        size: 48),
                                  ),
                                )
                              : Image.file(
                                  File(_previewUrl!),
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            onPressed: _handleRemoveFile,
                          ),
                        ),
                      ],
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
        ),
      ),
    );
  }
}

