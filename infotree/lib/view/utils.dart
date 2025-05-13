import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:infotree/model/benefit_data.dart';

/// 채널 ID 리스트로 채널 이름 맵 가져오기
Future<List<String>> getChannelNames(List<int> ids) async {
  final uri = Uri.parse('http://localhost:3000/channels/names');

  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ids': ids}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> channels = jsonData['channels'];

      // 채널 이름만 리스트로 반환
      return channels.values.map((name) => name.toString()).toList();
    } else {
      throw Exception('서버 오류: ${response.statusCode}');
    }
  } catch (e) {
    print('채널 이름 불러오기 실패: $e');
    return [];
  }
}

String formatDate(DateTime date) {
  return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
}

Future<List<BenefitData>> fetchLikedBenefits(List<int> ids) async {
  final uri = Uri.parse('http://localhost:3000/benefits/liked');

  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ids': ids}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => BenefitData.fromJson(e)).toList();
    } else {
      throw Exception('서버 오류: ${response.statusCode}');
    }
  } catch (e) {
    print('좋아요 혜택 로딩 실패: $e');
    return [];
  }
}
