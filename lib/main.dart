import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_quill/flutter_quill.dart'; // flutter_quill 패키지 추가
import 'package:flutter_localizations/flutter_localizations.dart'; // 지역화 패키지 추가

import 'home/home.dart'; // 메인 홈 스크린 경로
import 'login/login.dart'; // 로그인 스크린 경로
import 'firebase_options.dart'; // Firebase 옵션 파일
import 'sidebarmenu/trending_content.dart';
import 'sidebarmenu/bookmark.dart';
import 'sidebarmenu/history.dart';
import 'sidebarmenu/featured_members.dart';
import 'sidebarmenu/follow_feed.dart';
import 'sidebarmenu/tag_explore.dart';
import 'post/post_create.dart'; // 글쓰기 페이지 추가
import 'sidebarmenu/guidebook.dart'; // 가이드북 페이지 추가
import 'sidebarmenu/update.dart'; // 업데이트 페이지 추가
import 'sidebarmenu/support_center.dart'; // 고객센터 페이지 추가

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
          backgroundColor: Colors.black.withOpacity(0.5),
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Pretendard',
        ),
      )
          : ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFFFFFF0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFFFF0).withOpacity(0.5),
        ),
        textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Pretendard',
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // FlutterQuill의 지역화 추가 (필요한 경우 주석 해제)
        // FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // 영어
        Locale('ko'), // 한국어
        // 필요한 언어를 추가로 여기에 나열하세요
      ],
      home: HomeScreen(
        isDarkMode: isDarkMode,
        toggleTheme: _toggleTheme,
      ),
      routes: {
        '/home': (context) => HomeScreen(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/trendingContent': (context) => TrendingContentPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/bookmark': (context) => BookmarkPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/history': (context) => HistoryPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/featuredMembers': (context) => FeaturedMembersPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/followFeed': (context) => FollowFeedPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/tagExplore': (context) => TagExplorePage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/postCreate': (context) => PostCreatePage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/guidebook': (context) => GuidebookPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/update': (context) => UpdatePage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/supportCenter': (context) => SupportCenterPage(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
        '/login': (context) => LoginScreen(
          isDarkMode: isDarkMode,
          toggleTheme: _toggleTheme,
        ),
      },
    );
  }

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}
