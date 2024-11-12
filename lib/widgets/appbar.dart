import 'package:flutter/material.dart';
import '../login/login.dart'; // LoginScreen 경로 추가

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final Widget? leading;
  final Color backgroundColor;

  CommonAppBar({
    required this.isDarkMode,
    required this.toggleTheme,
    this.leading,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // 검색창의 너비를 동적으로 설정
    double screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth * 0.3;
    if (searchWidth > 500) searchWidth = 500;
    if (searchWidth < 240) searchWidth = 240;

    return AppBar(
      backgroundColor: backgroundColor,
      leading: leading,
      title: Row(
        children: [
          Text(
            'Yolog',
            style: TextStyle(
              color: Color(0xFF4169E1),
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              fontFamily: 'Pretendard',
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
                hintText: '검색',
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
            // 로그인 페이지로 이동하는 기능 구현
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // LoginScreen 위젯을 사용하여 로그인 창 표시
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
