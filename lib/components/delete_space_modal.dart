import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';

class DeleteSpaceModal extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final VoidCallback onConfirm;
  final String spaceName;

  const DeleteSpaceModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.onConfirm,
    required this.spaceName,
  });

  @override
  State<DeleteSpaceModal> createState() => _DeleteSpaceModalState();
}

class _DeleteSpaceModalState extends State<DeleteSpaceModal> {
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  void _handleClose() {
    _confirmController.clear();
    widget.onClose();
  }

  void _handleConfirm() {
    if (_confirmController.text == widget.spaceName) {
      _confirmController.clear();
      widget.onConfirm();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) return const SizedBox.shrink();

    final darkMode = Provider.of<DarkModeProvider>(context);
    final isConfirmValid = _confirmController.text == widget.spaceName;

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
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 32,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Space?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete "${widget.spaceName}"? This action cannot be undone and all posts in this space will be permanently deleted.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: darkMode.isDarkMode
                      ? const Color(0xFF999999)
                      : const Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Type ${widget.spaceName} to confirm:',
                  style: TextStyle(
                    fontSize: 12,
                    color: darkMode.isDarkMode
                        ? const Color(0xFF999999)
                        : const Color(0xFF4B5563),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Type "${widget.spaceName}"',
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
                      color: Colors.red,
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
                      onPressed: _handleClose,
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
                      onPressed: isConfirmValid ? _handleConfirm : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isConfirmValid
                            ? Colors.red
                            : const Color(0xFFD1D5DB),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Delete Space',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: isConfirmValid
                              ? Colors.white
                              : const Color(0xFF6B7280),
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

