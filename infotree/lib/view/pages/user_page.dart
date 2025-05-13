import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../model/data.dart';
import '../../model/user_data.dart';
import '../pages/channel_page.dart';

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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            buildInfoTile('이름', data.user.name),
                            buildInfoTile('학교', data.user.school),
                            buildInfoTile('학년', data.user.grade.toString()),
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
                          ],
                        ),
                      ),
                    ),
          ),
    );
  }
}
