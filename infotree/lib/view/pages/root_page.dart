import 'package:flutter/material.dart';
import 'package:infotree/model/dummy/dummy_notification.dart';
import 'package:infotree/model/user.dart';
import 'package:infotree/model/user_data.dart';
import 'package:infotree/view/pages/user_page.dart';
import 'main_page.dart';
import 'subscribe_page.dart';
import 'chat_page.dart';
import 'map_page.dart';
import 'package:provider/provider.dart';
import 'package:infotree/model/data.dart';
import 'package:infotree/model/notification_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() {
    return _RootPageState();
  }
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 2;

  // 페이지 목록

  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).fetchUserFromServer();
    //mainUser = Provider.of<Data>(context, listen: false).user;
  }

  @override
  Widget build(BuildContext context) {
    mainUser = Provider.of<Data>(context, listen: false).user.copyWith();

    final List<Widget> pages = [
      SubscribePage(), // 첫 페이지는 즐겨찾기
      ChatPage(), // 검색
      MainPage(), // 빈 하트
      MapPage(), // 알림
      ProfilePage(), // 프로필
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
