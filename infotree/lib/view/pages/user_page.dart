import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:infotree/model/user_data.dart';
import 'package:infotree/model/data.dart';
import 'package:infotree/view/pages/channel_page.dart';
import 'package:infotree/view/pages/user_edit_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<int, String> channelNames = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChannelNames();
  }

  Future<void> _loadChannelNames() async {
    final data = Provider.of<Data>(context, listen: false);
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/channels/names'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'ids': data.user.channel}),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final Map<String, dynamic> names = jsonData['channels'];
        setState(() {
          channelNames = names.map(
            (key, value) => MapEntry(int.parse(key), value as String),
          );
          isLoading = false;
        });
      }
    } catch (e) {
      print('채널 이름 로딩 실패: $e');
      setState(() => isLoading = false);
    }
  }

  Widget buildInfoTile(String title, String content) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(content),
    );
  }

  // 로그 아웃 처리 함수
  void _handleLogout() {
    // 여기에 로그 아웃 로직을 추가하세요.
    print('로그 아웃');
    // 예를 들어 로그인 페이지로 이동하거나 세션 데이터를 삭제할 수 있습니다.
  }

  // 프로필 수정 처리 함수
  void _handleEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => UserEditPage()), // UserEditPage로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder:
          (context, data, child) => Scaffold(
            appBar: AppBar(title: const Text('내 프로필')),
            body:
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: _handleEditProfile, // 프로필 수정
                                child: const Text(
                                  '프로필 수정',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: _handleLogout, // 로그 아웃
                                child: const Text(
                                  '로그 아웃',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          buildInfoTile('이름', data.user.name),
                          buildInfoTile('학교', data.user.school),
                          //buildInfoTile('학년', data.user.grade.toString()),
                          buildInfoTile('이메일', data.user.email),
                          buildInfoTile('전화번호', data.user.phone),
                          buildInfoTile('전공', data.user.major.join(', ')),

                          const SizedBox(height: 12),
                          const Text(
                            '참여 채널',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...data.user.channel.map((id) {
                            final name = channelNames[id] ?? '채널 $id';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => ChannelPage(channelId: id),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.chevron_right),
                                label: Text(name),
                              ),
                            );
                          }),

                          // "프로필 수정"과 "로그 아웃" 버튼을 1줄로 배치
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
          ),
    );
  }
}
