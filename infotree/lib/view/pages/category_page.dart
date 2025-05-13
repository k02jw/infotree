import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:infotree/model/benefit_data.dart';
import 'package:infotree/view/benefit_list_view.dart';

class CategoryBenefitPage extends StatefulWidget {
  final String category;

  const CategoryBenefitPage({super.key, required this.category});

  @override
  State<CategoryBenefitPage> createState() => _CategoryBenefitPageState();
}

class _CategoryBenefitPageState extends State<CategoryBenefitPage> {
  List<BenefitData> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCategoryBenefits();
  }

  Future<void> _fetchCategoryBenefits() async {
    final uri = Uri.parse('http://localhost:3000/benefits/category');

    try {
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'category': widget.category}),
      );

      if (res.statusCode == 200) {
        final jsonList = json.decode(res.body) as List;
        setState(() {
          items = jsonList.map((e) => BenefitData.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('서버 오류: ${res.statusCode}');
      }
    } catch (e) {
      print('카테고리 혜택 불러오기 실패: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.category} 혜택')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : items.isEmpty
              ? const Center(child: Text('해당 카테고리의 유효한 혜택이 없습니다.'))
              : BenefitListView(items: items),
    );
  }
}
