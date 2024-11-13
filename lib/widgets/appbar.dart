import 'package:flutter/material.dart';
import 'dart:ui';
import '../login/login.dart'; // LoginScreen 경로 추가

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final Widget? leading;
  final Color backgroundColor; // backgroundColor 매개변수 추가

  CommonAppBar({
    required this.isDarkMode,
    required this.toggleTheme,
    this.leading,
    required this.backgroundColor, // backgroundColor 받기
  });

  @override
  Widget build(BuildContext context) {
    // 검색창의 너비를 동적으로 설정
    double screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth * 0.3;
    if (searchWidth > 500) searchWidth = 500;
    if (searchWidth < 240) searchWidth = 240;

    return AppBar(
      backgroundColor: backgroundColor.withOpacity(0.7), // 투명도 설정
      elevation: 0, // 그림자 제거
      leading: leading,
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
                prefixIcon: Icon(
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
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Color(0xFF4169E1),
          ),
          onPressed: toggleTheme,
        ),
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
              fontFamily: 'Pretendard',
            ),
          ),
        ),
      ],
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0), // 블러 효과 추가
          child: Container(
            color: Colors.transparent, // 투명 배경
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
