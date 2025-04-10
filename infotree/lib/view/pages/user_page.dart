import '../../model/user_data.dart';
import '../../model/user.dart';
import 'package:flutter/material.dart';
import '../../model/data.dart';
import 'package:provider/provider.dart';
import 'package:infotree/model/data.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget buildInfoTile(String title, String content) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(content),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<Data>().user.email);
    return Consumer<Data>(
      builder:
          (context, data, child) => Scaffold(
            appBar: AppBar(title: Text('내 프로필')),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.teal,
                    child: Text(
                      mainUser.name.substring(0, 1),
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  buildInfoTile('이름', data.user.name),
                  buildInfoTile('학교', data.user.school),
                  buildInfoTile('이메일', data.user.email),
                  buildInfoTile('전화번호', data.user.phone),
                  buildInfoTile('전공', data.user.major.join(', ')),
                  buildInfoTile('참여 채널', data.user.channel.join(', ')),
                ],
              ),
            ),
          ),
    );
  }
}
