import 'package:flutter/material.dart';
import 'package:infotree/view/benefit_list_view.dart';

import 'package:infotree/view/channel_list_view.dart';

import 'package:infotree/model/dummy/dummy_benefits.dart';

import 'package:flutter/material.dart';
import 'package:infotree/model/benefit_data.dart';
import 'package:infotree/view/benefit_list_view.dart';
import 'package:infotree/model/data.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:infotree/model/channel_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  List<BenefitData> filteredBenefits = []; // 필터링된 혜택 목록
  List<ChannelData> filteredChannels = []; // 필터링된 채널 목록

  bool isLoadingBenefits = false;
  bool isLoadingChannels = false;

  @override
  void initState() {
    super.initState();
    // 페이지 진입 후 바로 포커스 요청
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // 데이터베이스에서 검색어로 혜택을 필터링하는 함수
  Future<void> _filterBenefitsFromDatabase(String query) async {
    setState(() {
      isLoadingBenefits = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:3000/benefits/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'searchTerm': query}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<BenefitData> benefits =
          (jsonData as List).map((e) => BenefitData.fromJson(e)).toList();

      setState(() {
        filteredBenefits = benefits; // 백엔드에서 받은 혜택으로 업데이트
        isLoadingBenefits = false;
      });
    } else {
      setState(() {
        isLoadingBenefits = false;
      });
    }
  }

  // 데이터베이스에서 검색어로 채널을 필터링하는 함수
  Future<void> _filterChannelsFromDatabase(String query) async {
    setState(() {
      isLoadingChannels = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:3000/channels/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'searchTerm': query}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Convert the response data to a list of ChannelData objects
      setState(() {
        filteredChannels =
            data
                .map((channel) => ChannelData.fromJson(channel))
                .toList(); // Use ChannelData.fromJson to create objects
        isLoadingChannels = false;
      });
    } else {
      setState(() {
        isLoadingChannels = false;
      });
    }
  }

  // 데이터베이스와 benefitGroups에서 모두 검색하는 함수
  void _filterSearchResults(String query) {
    setState(() {
      filteredBenefits.clear();
      filteredChannels.clear();
    });

    // 혜택 및 채널 검색
    _filterBenefitsFromDatabase(query);
    _filterChannelsFromDatabase(query);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: theme.appBarTheme.elevation ?? 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
            onPressed: () => Navigator.pop(context),
          ),
          title: Container(
            height: 44,
            decoration: BoxDecoration(
              color: theme.inputDecorationTheme.fillColor ?? Colors.grey[900],
              borderRadius: BorderRadius.circular(999),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
              cursorColor: theme.textTheme.bodyMedium?.color,
              decoration: InputDecoration(
                hintText: '검색',
                hintStyle: theme.inputDecorationTheme.hintStyle,
                prefixIcon: const Icon(Icons.search, size: 20),
                isDense: true,
                filled: true,
                fillColor:
                    theme.inputDecorationTheme.fillColor ?? Colors.grey[900],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
              ),
              onEditingComplete: () {
                _filterSearchResults(_searchController.text);
                FocusScope.of(context).unfocus(); // 키보드 숨기기
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _filterSearchResults(_searchController.text);
              },
            ),
          ],
          bottom: TabBar(
            tabs: const [Tab(text: '혜택'), Tab(text: '채널')],
            indicatorColor:
                theme.tabBarTheme.indicatorColor ??
                theme.colorScheme.onBackground,
            labelColor: theme.tabBarTheme.labelColor,
            unselectedLabelColor: theme.tabBarTheme.unselectedLabelColor,
          ),
        ),
        body: TabBarView(
          children: [
            // '혜택' 탭에 필터링된 리스트 전달
            isLoadingBenefits
                ? const Center(child: CircularProgressIndicator())
                : BenefitListView(items: filteredBenefits),
            // '채널' 탭에 필터링된 채널 리스트 전달
            isLoadingChannels
                ? const Center(child: CircularProgressIndicator())
                : ChannelListView(channels: filteredChannels),
          ],
        ),
      ),
    );
  }
}
