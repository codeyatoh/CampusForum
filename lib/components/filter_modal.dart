import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onClose;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterModal({
    super.key,
    required this.isOpen,
    required this.onClose,
    required this.onApplyFilters,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final List<String> _selectedCategories = [];
  String _sortBy = 'recent';
  String _timeRange = 'all';

  final List<String> _categories = [
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

  final List<Map<String, String>> _sortOptions = [
    {'value': 'recent', 'label': 'Most Recent'},
    {'value': 'popular', 'label': 'Most Popular'},
    {'value': 'comments', 'label': 'Most Commented'},
  ];

  final List<Map<String, String>> _timeRanges = [
    {'value': 'all', 'label': 'All Time'},
    {'value': 'today', 'label': 'Today'},
    {'value': 'week', 'label': 'This Week'},
    {'value': 'month', 'label': 'This Month'},
  ];

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _handleApply() {
    widget.onApplyFilters({
      'categories': _selectedCategories,
      'sortBy': _sortBy,
      'timeRange': _timeRange,
    });
    widget.onClose();
  }

  void _handleReset() {
    setState(() {
      _selectedCategories.clear();
      _sortBy = 'recent';
      _timeRange = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOpen) return const SizedBox.shrink();

    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose,
                    color: const Color(0xFF9CA3AF),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((category) {
                  final isSelected = _selectedCategories.contains(category);
                  return InkWell(
                    onTap: () => _toggleCategory(category),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8B4513)
                            : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF374151),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              ..._sortOptions.map((option) {
                final isSelected = _sortBy == option['value'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _sortBy = option['value']!;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8B4513)
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        option['label']!,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              Text(
                'Time Range',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              ..._timeRanges.map((range) {
                final isSelected = _timeRange == range['value'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _timeRange = range['value']!;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8B4513)
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        range['label']!,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _handleReset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFFD1D5DB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B4513),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Apply',
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

