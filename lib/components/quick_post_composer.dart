import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import '../contexts/dark_mode_context.dart';

class QuickPostComposer extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final String userAvatar;
  final bool isSmallScreen;

  const QuickPostComposer({
    super.key,
    required this.onSubmit,
    this.userAvatar = '😊',
    this.isSmallScreen = false,
  });

  @override
  State<QuickPostComposer> createState() => _QuickPostComposerState();
}

class _QuickPostComposerState extends State<QuickPostComposer> {
  bool _isExpanded = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'All';
  String? _previewUrl;
  bool _isVideo = false;
  Uint8List? _imageBytes;

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
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if (image != null) {
        try {
          // For web, read bytes directly from XFile
          if (kIsWeb) {
            final bytes = await image.readAsBytes();
            setState(() {
              _previewUrl = image.path; // Keep path for reference
              _imageBytes = bytes;
              _isVideo = false;
            });
          } else {
            // For mobile, verify file exists and read bytes
            final file = File(image.path);
            if (await file.exists()) {
              final bytes = await image.readAsBytes();
              setState(() {
                _previewUrl = image.path;
                _imageBytes = bytes;
                _isVideo = false;
              });
            } else {
              _showError('Selected file not found');
            }
          }
        } catch (e) {
          _showError('Failed to read image: ${e.toString()}');
        }
      }
    } catch (e) {
      // Handle specific errors
      String errorMessage = 'Failed to pick image';
      if (e.toString().contains('permission')) {
        errorMessage = 'Permission denied. Please allow camera/gallery access in settings.';
      } else if (e.toString().contains('Unsupported operation') || e.toString().contains('_Namespace')) {
        errorMessage = 'Image picker not supported on this platform. Please use a mobile device.';
      } else {
        errorMessage = 'Failed to pick image: ${e.toString()}';
      }
      _showError(errorMessage);
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? video = await picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 10),
        preferredCameraDevice: CameraDevice.rear,
      );
      
      if (video != null) {
        try {
          // For web, read bytes directly from XFile
          if (kIsWeb) {
            final bytes = await video.readAsBytes();
            setState(() {
              _previewUrl = video.path; // Keep path for reference
              _imageBytes = bytes;
              _isVideo = true;
            });
          } else {
            // For mobile, verify file exists
            final file = File(video.path);
            if (await file.exists()) {
              setState(() {
                _previewUrl = video.path;
                _imageBytes = null; // Don't store video bytes, too large
                _isVideo = true;
              });
            } else {
              _showError('Selected file not found');
            }
          }
        } catch (e) {
          _showError('Failed to read video: ${e.toString()}');
        }
      }
    } catch (e) {
      // Handle specific errors
      String errorMessage = 'Failed to pick video';
      if (e.toString().contains('permission')) {
        errorMessage = 'Permission denied. Please allow camera/gallery access in settings.';
      } else if (e.toString().contains('Unsupported operation') || e.toString().contains('_Namespace')) {
        errorMessage = 'Video picker not supported on this platform. Please use a mobile device.';
      } else {
        errorMessage = 'Failed to pick video: ${e.toString()}';
      }
      _showError(errorMessage);
    }
  }
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleRemoveFile() {
    setState(() {
      _previewUrl = null;
      _imageBytes = null;
      _isVideo = false;
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit({
        'title': _titleController.text,
        'content': _contentController.text,
        'category': _selectedCategory,
        'image': _isVideo ? null : _previewUrl,
        'video': _isVideo ? _previewUrl : null,
      });
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _selectedCategory = 'All';
        _previewUrl = null;
        _imageBytes = null;
        _isVideo = false;
        _isExpanded = false;
      });
    }
  }

  void _handleCancel() {
    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedCategory = 'All';
      _previewUrl = null;
      _imageBytes = null;
      _isVideo = false;
      _isExpanded = false;
    });
  }

  Future<ImageProvider> _getImageFile(String path) async {
    try {
      // If we have bytes in memory (especially for web), use them directly
      if (_imageBytes != null && _imageBytes!.isNotEmpty) {
        return MemoryImage(_imageBytes!);
      }
      
      // For mobile, read from file path
      if (!kIsWeb) {
        final file = File(path);
        if (await file.exists()) {
          final bytes = await file.readAsBytes();
          if (bytes.isEmpty) throw Exception('Empty file');
          return MemoryImage(bytes);
        }
        throw Exception('File not found');
      }
      
      // Fallback for web if bytes not available
      throw Exception('Image data not available');
    } catch (e) {
      debugPrint('Image loading error: $e');
      throw Exception('Failed to load image: ${e.toString()}');
    }
  }

  Widget _buildVideoPreview() {
    final darkMode = Provider.of<DarkModeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: darkMode.isDarkMode
              ? const Color(0xFF444444)
              : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 300,
              minHeight: 200,
            ),
            decoration: BoxDecoration(
              color: darkMode.isDarkMode
                  ? const Color(0xFF1E1E1E)
                  : const Color(0xFFF9FAFB),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.videocam,
                  size: 64,
                  color: darkMode.isDarkMode
                      ? const Color(0xFF999999)
                      : const Color(0xFF6B7280),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: darkMode.isDarkMode
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF3F4F6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Video attached',
                  style: TextStyle(
                    fontSize: 12,
                    color: darkMode.isDarkMode
                        ? const Color(0xFFA1A1AA)
                        : const Color(0xFF6B7280),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 16,
                    color: darkMode.isDarkMode
                        ? const Color(0xFFA1A1AA)
                        : const Color(0xFF6B7280),
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: _handleRemoveFile,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    if (!_isExpanded) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: InkWell(
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: darkMode.isDarkMode
                  ? const Color(0xFF2A2A2A)
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B4513),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.userAvatar,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "What's on your mind?",
                    style: TextStyle(
                      fontSize: 14,
                      color: darkMode.isDarkMode
                          ? const Color(0xFF999999)
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: darkMode.isDarkMode
              ? const Color(0xFF2A2A2A)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: darkMode.isDarkMode
                ? const Color(0xFF2A2A2A)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B4513),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  filled: true,
                  fillColor: darkMode.isDarkMode
                      ? const Color(0xFF1A1A1A)
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
              const SizedBox(height: 12),
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
                  ),
                ),
                style: TextStyle(
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                  fontSize: 14,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Content',
                  hintText: "What's on your mind?",
                  filled: true,
                  fillColor: darkMode.isDarkMode
                      ? const Color(0xFF1A1A1A)
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                style: TextStyle(
                  color: darkMode.isDarkMode
                      ? Colors.white
                      : const Color(0xFF111827),
                  fontSize: 14,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Attach Media (optional)',
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickVideo(ImageSource.gallery),
                        icon: const Icon(Icons.videocam),
                        label: const Text('Video'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                )
              else
                _isVideo
                    ? _buildVideoPreview()
                    : FutureBuilder<ImageProvider>(
                        future: _getImageFile(_previewUrl!),
                        builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: darkMode.isDarkMode
                              ? const Color(0xFF1E1E1E)
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B4513)),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError || !snapshot.hasData) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: darkMode.isDarkMode
                              ? const Color(0xFF1E1E1E)
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.red.shade300,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red, size: 48),
                              const SizedBox(height: 8),
                              Text(
                                'Failed to load image',
                                style: TextStyle(
                                  color: darkMode.isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: darkMode.isDarkMode
                              ? const Color(0xFF444444)
                              : const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                              maxHeight: 300,
                              minHeight: 200,
                            ),
                            decoration: BoxDecoration(
                              color: darkMode.isDarkMode
                                  ? const Color(0xFF1E1E1E)
                                  : const Color(0xFFF9FAFB),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image(
                                image: snapshot.data!,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  debugPrint('Image error: $error');
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Could not load image',
                                          style: TextStyle(
                                            color: darkMode.isDarkMode
                                                ? Colors.white70
                                                : Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                      strokeWidth: 2,
                                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B4513)),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: darkMode.isDarkMode
                                  ? const Color(0xFF2A2A2A)
                                  : const Color(0xFFF3F4F6),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _isVideo ? 'Video attached' : 'Image attached',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: darkMode.isDarkMode
                                        ? const Color(0xFFA1A1AA)
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: darkMode.isDarkMode
                                        ? const Color(0xFFA1A1AA)
                                        : const Color(0xFF6B7280),
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: _handleRemoveFile,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _handleCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B4513),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
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

