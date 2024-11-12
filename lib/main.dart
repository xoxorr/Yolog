import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home/home.dart'; // 메인 홈 스크린 경로
//import 'login/login_screen.dart'; // 로그인 스크린 경로
import 'firebase_options.dart'; // Firebase 옵션 파일

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          backgroundColor: Colors.black.withOpacity(0.5), // 불투명 설정
        ),
      )
          : ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFFFFFF0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFFFF0).withOpacity(0.5), // 불투명 설정
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