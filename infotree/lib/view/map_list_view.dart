import 'package:flutter/material.dart';
import '../model/benefit_data.dart';
import 'pages/benefits_page.dart';

class MapListView extends StatefulWidget {
  const MapListView({
    super.key,
    required this.items,
    this.onItemTap,
    this.scrollController,
  });

  final List<BenefitData> items;
  final void Function(BenefitData)? onItemTap;
  final ScrollController? scrollController;

  @override
  State<MapListView> createState() => _MapListViewState();
}

class _MapListViewState extends State<MapListView> {
  late List<bool> likedStates;

  @override
  void initState() {
    super.initState();
    likedStates = List<bool>.filled(widget.items.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: widget.scrollController,
      itemCount: widget.items.length,
      itemBuilder: (_, index) {
        final item = widget.items[index];
        final isLiked = likedStates[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                item.image != null
                    ? NetworkImage(item.image!)
                    : const AssetImage('assets/default.jpg') as ImageProvider,
          ),
          title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            '${item.startDate.year}.${item.startDate.month}.${item.startDate.day} ~ '
            '${item.endDate.year}.${item.endDate.month}.${item.endDate.day}',
          ),
          trailing: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : Colors.grey,
          ),

          onTap: () {
            widget.onItemTap?.call(item);
          },
        );
      },
    );
  }
}
