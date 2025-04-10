import 'package:flutter/material.dart';

class HeaderSlidebar extends StatelessWidget {
  const HeaderSlidebar({super.key, required this.filters});

  final List<String> filters;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children:
            filters.map((text) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text(text),
                  selected: text == '좋아요', // 임의로 선택 표시
                  onSelected: (_) {},
                ),
              );
            }).toList(),
      ),
    );
  }
}
