import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';

class CommentInput extends StatefulWidget {
  final Function(String) onSubmit;
  final String placeholder;
  final String userAvatar;

  const CommentInput({
    super.key,
    required this.onSubmit,
    this.placeholder = 'Write a comment...',
    this.userAvatar = '😊',
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSubmit(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF8B4513),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              widget.userAvatar,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                color: darkMode.isDarkMode
                    ? const Color(0xFF999999)
                    : const Color(0xFF6B7280),
              ),
              filled: true,
              fillColor: darkMode.isDarkMode
                  ? const Color(0xFF1A1A1A)
                  : const Color(0xFFF3F4F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: darkMode.isDarkMode
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFE5E7EB),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: darkMode.isDarkMode
                      ? const Color(0xFF2A2A2A)
                      : const Color(0xFFE5E7EB),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color(0xFF8B4513),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 16,
                  color: _controller.text.trim().isNotEmpty
                      ? const Color(0xFF8B4513)
                      : darkMode.isDarkMode
                          ? const Color(0xFF999999)
                          : const Color(0xFF9CA3AF),
                ),
                onPressed: _controller.text.trim().isNotEmpty
                    ? _handleSubmit
                    : null,
              ),
            ),
            style: TextStyle(
              color: darkMode.isDarkMode
                  ? Colors.white
                  : const Color(0xFF111827),
              fontSize: 14,
            ),
            onSubmitted: (_) => _handleSubmit(),
            onChanged: (value) => setState(() {}),
          ),
        ),
      ],
    );
  }
}

