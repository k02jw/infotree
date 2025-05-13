import 'package:flutter/material.dart';

class HeaderSlidebar extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final void Function(String selected)? onTap;

  const HeaderSlidebar({
    super.key,
    required this.filters,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = filters[index];
          final isSelected = label == selected;

          return GestureDetector(
            onTap: () => onTap?.call(label),
            child: Chip(
              label: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
              backgroundColor:
                  isSelected ? Colors.black87 : Colors.grey.shade200,
              shape: StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          );
        },
      ),
    );
  }
}
