import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';
import 'comment_input.dart';

class CommentCard extends StatefulWidget {
  final int id;
  final String author;
  final String avatar;
  final String content;
  final String time;
  final int likes;
  final Function(int, String)? onReply;

  const CommentCard({
    super.key,
    required this.id,
    required this.author,
    required this.avatar,
    required this.content,
    required this.time,
    required this.likes,
    this.onReply,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late int _likes;
  bool _isLiked = false;
  bool _showReply = false;

  @override
  void initState() {
    super.initState();
    _likes = widget.likes;
  }

  void _handleLike() {
    setState(() {
      if (_isLiked) {
        _likes--;
      } else {
        _likes++;
      }
      _isLiked = !_isLiked;
    });
  }

  void _handleReply(String reply) {
    widget.onReply?.call(widget.id, reply);
    setState(() {
      _showReply = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
            ),
            child: Center(
              child: Text(
                widget.avatar,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: darkMode.isDarkMode
                        ? const Color(0xFF1A1A1A)
                        : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.author,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: darkMode.isDarkMode
                              ? Colors.white
                              : const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: darkMode.isDarkMode
                              ? const Color(0xFF999999)
                              : const Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: _handleLike,
                        child: Row(
                          children: [
                            Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              size: 14,
                              color: _isLiked
                                  ? Colors.red
                                  : darkMode.isDarkMode
                                      ? const Color(0xFF999999)
                                      : const Color(0xFF6B7280),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$_likes',
                              style: TextStyle(
                                fontSize: 12,
                                color: _isLiked
                                    ? Colors.red
                                    : darkMode.isDarkMode
                                        ? const Color(0xFF999999)
                                        : const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _showReply = !_showReply;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.reply,
                              size: 14,
                              color: darkMode.isDarkMode
                                  ? const Color(0xFF999999)
                                  : const Color(0xFF6B7280),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Reply',
                              style: TextStyle(
                                fontSize: 12,
                                color: darkMode.isDarkMode
                                    ? const Color(0xFF999999)
                                    : const Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        widget.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: darkMode.isDarkMode
                              ? const Color(0xFF999999)
                              : const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showReply) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CommentInput(
                      onSubmit: _handleReply,
                      placeholder: 'Reply to ${widget.author}...',
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

