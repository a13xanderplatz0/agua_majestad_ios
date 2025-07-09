import 'package:flutter/cupertino.dart';
import 'screens/home_page.dart';
import 'screens/loading_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
    );
  }
}