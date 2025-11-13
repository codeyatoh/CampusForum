import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';

class PasswordInput extends StatefulWidget {
  final String value;
  final Function(String) onChange;
  final String placeholder;
  final String? className;
  final Widget? leftIcon;

  const PasswordInput({
    super.key,
    required this.value,
    required this.onChange,
    this.placeholder = 'Password',
    this.className,
    this.leftIcon,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return TextField(
      obscureText: !_showPassword,
      controller: TextEditingController(text: widget.value)
        ..selection = TextSelection.collapsed(offset: widget.value.length),
      onChanged: widget.onChange,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        prefixIcon: widget.leftIcon != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: widget.leftIcon,
              )
            : null,
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility_off : Icons.visibility,
            color: darkMode.isDarkMode
                ? const Color(0xFF6B7280)
                : const Color(0xFF9CA3AF),
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
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
    );
  }
}

