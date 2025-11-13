import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../contexts/dark_mode_context.dart';

class CategoryChips extends StatefulWidget {
  final List<String> categories;
  final Function(String) onSelectCategory;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.onSelectCategory,
  });

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String selectedCategory = 'All';

  void _handleCategorySelect(String category) {
    setState(() {
      selectedCategory = category;
    });
    widget.onSelectCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<DarkModeProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: widget.categories.map((category) {
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => _handleCategorySelect(category),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF8B4513)
                      : darkMode.isDarkMode
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                  border: !isSelected && darkMode.isDarkMode
                      ? Border.all(color: const Color(0xFF2A2A2A))
                      : null,
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected
                        ? Colors.white
                        : darkMode.isDarkMode
                            ? const Color(0xFF999999)
                            : const Color(0xFF374151),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

