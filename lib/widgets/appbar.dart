import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/login.dart'; // LoginScreen 경로 추가

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final Color backgroundColor;
  final List<Widget>? actions;

  CommonAppBar({
    required this.isDarkMode,
    required this.toggleTheme,
    required this.backgroundColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser; // 현재 로그인된 사용자 가져오기

    // 검색창의 너비를 동적으로 설정
    double screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth * 0.3;
    if (searchWidth > 500) searchWidth = 500;
    if (searchWidth < 240) searchWidth = 240;

    return AppBar(
      backgroundColor: backgroundColor.withOpacity(0.7),
      elevation: 0,
      automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(
              'Yolog',
              style: TextStyle(
                color: Color(0xFF4169E1),
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                fontFamily: 'Pretendard',
              ),
            ),
          ),
          Spacer(),
          // 검색창
          Container(
            width: searchWidth,
            child: TextField(
              style: TextStyle(
                fontFamily: 'Pretendard',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                hintText: '검색어를 입력해주세요!',
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard',
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[700],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.grey : Colors.black,
                  ),
                ),
                filled: true,
                fillColor: isDarkMode
                    ? Colors.grey[800]?.withOpacity(0.5)
                    : Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
      actions: [
        // 다크 모드 변환 버튼: 항상 표시
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Color(0xFF4169E1),
          ),
          onPressed: toggleTheme,
        ),
        // 로그인 상태에 따른 UI
        if (user == null)
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: LoginScreen(
                      isDarkMode: isDarkMode,
                      toggleTheme: toggleTheme,
                    ),
                  );
                },
              );
            },
            child: Text(
              '로그인',
              style: TextStyle(
                color: Color(0xFF4169E1),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
              ),
            ),
          )
        else
          PopupMenuButton<String>(
            color: Colors.white, // 메뉴 배경을 흰색으로 설정
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: user.photoURL != null
                  ? Image.network(
                user.photoURL!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              )
                  : Icon(
                Icons.account_circle,
                size: 40,
                color: Color(0xFF4169E1),
              ),
            ),
            onSelected: (value) {
              if (value == 'settings') {
                // 설정 페이지로 이동하는 로직 추가
              } else if (value == 'logout') {
                FirebaseAuth.instance.signOut(); // 로그아웃
                Navigator.of(context).popUntil((route) => route.isFirst); // 홈 화면으로 이동
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'settings',
                  child: Text('설정'),
                ),
                PopupMenuItem(
                  value: 'logout',
                  child: Text('로그아웃'),
                ),
              ];
            },
          ),
      ],
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
