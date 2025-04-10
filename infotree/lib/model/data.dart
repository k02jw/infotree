import 'package:flutter/material.dart';
import 'package:infotree/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Data extends ChangeNotifier {
  UserData user = UserData(
    id: 0,
    name: '',
    school: '',
    email: 'email',
    phone: 'phone',
    major: [],
    channel: [],
    keywords: [],
    likes: [],
  );

  Future<void> fetchUserFromServer() async {
    final uri = Uri.parse('http://localhost:3000/users/1'); // 주소 수정 가능

    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        user = UserData.fromJson(jsonData); // ✅ 갱신
        notifyListeners(); // ✅ 리스너에게 알림
      } else {
        throw Exception('서버 오류: ${res.statusCode}');
      }
    } catch (e) {
      print('유저 데이터 가져오기 실패: $e');
    }
  }
}
