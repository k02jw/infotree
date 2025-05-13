import 'package:flutter/material.dart';
import 'package:infotree/view/benefit_list_view.dart';
import 'package:provider/provider.dart';
import '../header_slidebar.dart';
import '../../model/benefit_data.dart';
import '../../model/user_data.dart';
import 'package:infotree/model/dummy/dummy_benefits.dart';
import 'package:infotree/model/data.dart';
import 'package:provider/provider.dart';

class RecommandPage extends StatefulWidget {
  RecommandPage({super.key});

  @override
  State<RecommandPage> createState() => _RecommandPageState();
}

class _RecommandPageState extends State<RecommandPage> {
  final items = dummyBenefits;

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder:
          (context, data, child) => Scaffold(
            appBar: AppBar(title: Text('혜택 추천')),

            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Row(
                      children: [
                        Text('${data.user.name}님을 위한 추천 혜택을 모아봤어요'),
                        SizedBox(),
                      ],
                    ),
                  ),
                  Divider(),
                  BenefitListView(items: dummyBenefits),
                ],
              ),
            ),
          ),
    );
  }
}
