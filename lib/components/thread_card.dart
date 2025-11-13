import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../contexts/dark_mode_context.dart';
import 'comment_input.dart';

class ThreadCard extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final String author;
  final String? avatar;
  final String time;
  final int likes;
  final int comments;
  final int views;
  final String? image;
  final bool isOwner;
  final Function(int)? onEdit;
  final Function(int)? onDelete;
  final Map<String, String>? space;
  final bool isSmallScreen;

  const ThreadCard({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    this.avatar,
    required this.time,
    required this.likes,
    required this.comments,
    required this.views,
    this.image,
    this.isOwner = false,
    this.onEdit,
    this.onDelete,
    this.space,
    this.isSmallScreen = false,
  });

  @override
  State<ThreadCard> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  late int _likes;
  bool _isLiked = false;
  bool _showCommentInput = false;

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

  void _handleCommentClick() {
    setState(() {
      _showCommentInput = !_showCommentInput;
    });
  }

  void _handleCommentSubmit(String comment) {
    // Handle comment submission
    setState(() {
      _showCommentInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkMode.isDarkMode
            ? const Color(0xFF2A2A2A)
            : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.push('/user/${widget.author}');
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.avatar ?? '😊',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              context.push('/user/${widget.author}');
                            },
                            child: Text(
                              widget.author,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: darkMode.isDarkMode
                                    ? Colors.white
                                    : const Color(0xFF111827),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (widget.space != null) ...[
                          const SizedBox(width: 6),
                          Text(
                            'in',
                            style: TextStyle(
                              fontSize: 12,
                              color: darkMode.isDarkMode
                                  ? const Color(0xFFA1A1AA)
                                  : const Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: darkMode.isDarkMode
                                    ? const Color(0xFF333333)
                                    : const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: darkMode.isDarkMode
                                      ? const Color(0xFF444444)
                                      : const Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.space!['icon'] ?? '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      widget.space!['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: darkMode.isDarkMode
                                            ? const Color(0xFFFFB74D)
                                            : const Color(0xFF8B4513),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      widget.time,
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
              if (widget.isOwner)
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: darkMode.isDarkMode
                        ? const Color(0xFF999999)
                        : const Color(0xFF6B7280),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: () {
                        widget.onEdit?.call(widget.id);
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        widget.onDelete?.call(widget.id);
                      },
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              context.push('/thread/${widget.id}');
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                if (widget.image != null) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.image!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: _handleLike,
                    child: Row(
                      children: [
                        Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 16,
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
                    onTap: _handleCommentClick,
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment,
                          size: 16,
                          color: darkMode.isDarkMode
                              ? const Color(0xFF999999)
                              : const Color(0xFF6B7280),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.comments}',
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
                  Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 16,
                        color: darkMode.isDarkMode
                            ? const Color(0xFF999999)
                            : const Color(0xFF6B7280),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.views}',
                        style: TextStyle(
                          fontSize: 12,
                          color: darkMode.isDarkMode
                              ? const Color(0xFF999999)
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.share,
                size: 16,
                color: darkMode.isDarkMode
                    ? const Color(0xFF999999)
                    : const Color(0xFF6B7280),
              ),
            ],
          ),
          if (_showCommentInput) ...[
            const Divider(height: 24),
            CommentInput(
              onSubmit: _handleCommentSubmit,
              placeholder: 'Write a comment...',
            ),
          ],
        ],
      ),
    );
  }
}

