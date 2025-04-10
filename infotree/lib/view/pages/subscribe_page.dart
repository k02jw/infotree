import 'package:flutter/material.dart';
import '../header_slidebar.dart';
import '../subscribe_list_view.dart';
import '../../model/notification_data.dart';
import '../../model/user_data.dart';
import '../../model/dummy/dummy_notification.dart';

class SubscribePage extends StatefulWidget {
  SubscribePage({super.key});

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  final List<String> filters = ['좋아요', '컴퓨터공학과', 'CAPS', 'RUNTIME'];

  final items = dummyNotifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('구독 페이지')),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 상단 슬라이더
            HeaderSlidebar(filters: filters),
            Divider(),
            // ✅ 리스트
            SubscribeListView(items: items),
          ],
        ),
      ),
    );
  }
}
