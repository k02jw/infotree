import 'package:flutter/material.dart';
import '../model/notification_data.dart';
import '../view/pages/notification_page.dart';

class SubscribeListView extends StatefulWidget {
  const SubscribeListView({super.key, required this.items});

  final List<NotificationData> items;

  @override
  State<SubscribeListView> createState() => _SubscribeListViewState();
}

class _SubscribeListViewState extends State<SubscribeListView> {
  late List<bool> likedStates;

  @override
  void initState() {
    super.initState();
    likedStates = List<bool>.filled(widget.items.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
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
            title: Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${item.startDate.year}.${item.startDate.month}.${item.startDate.day} ~ '
              '${item.endDate.year}.${item.endDate.month}.${item.endDate.day}',
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      likedStates[index] = !isLiked;
                    });
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationPage(notification: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
