import 'package:flutter/material.dart';
import '../login/login.dart'; // LoginScreen 경로 추가

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final VoidCallback? onLogoTap; // Yolog 로고 클릭 동작 추가
  final bool automaticallyImplyLeading;

  CommonAppBar({
    required this.isDarkMode,
    required this.toggleTheme,
    this.onLogoTap,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      title: GestureDetector(
        onTap: onLogoTap, // 로고 클릭 시 동작 실행
        child: Text(
          'Yolog',
          style: TextStyle(
            color: Color(0xFF4169E1), // Yolog 색상
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Color(0xFF4169E1), // 아이콘 색상
          ),
          onPressed: toggleTheme,
        ),
        TextButton(
          onPressed: () {
            // 로그인 페이지를 팝업 창으로 표시
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent, // 배경을 투명하게 설정
                  child: LoginScreen(
                    isDarkMode: isDarkMode, // 다크 모드 상태 전달
                    toggleTheme: toggleTheme, // 테마 변경 함수 전달
                  ),
                );
              },
            );
          },
          child: Text(
            '로그인',
            style: TextStyle(
              color: Color(0xFF4169E1), // 로그인 텍스트 색상
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}