import 'package:flutter/material.dart';
import 'view/pages/root_page.dart';
import 'package:provider/provider.dart';
import 'view/pages/subscribe_page.dart'; // MyHomePage 위젯이 정의된 파일을 import
import 'package:infotree/model/data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Data(), // 하나의 Provider만 사용
      child: MaterialApp(
        title: 'Flutter Route Demo',
        initialRoute: '/root',
        routes: {
          '/subscribe': (context) => SubscribePage(),
          '/root': (context) => RootPage(),
        },
      ),
    );
  }
}
