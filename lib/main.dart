import 'package:flutter/material.dart';
import 'home/main_home.dart';

void main() {
  runApp(Yolog());
}

class Yolog extends StatefulWidget {
  @override
  _YologState createState() => _YologState();
}

class _YologState extends State<Yolog> {
  bool isDarkMode = false; // 다크 모드 상태 변수

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
      )
          : ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFFFFFF0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFFFF0),
        ),
      ),
      home: MainHomeScreen(
        isDarkMode: isDarkMode,
        toggleTheme: _toggleTheme,
      ),
    );
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // 테마 전환
    });
  }
}
