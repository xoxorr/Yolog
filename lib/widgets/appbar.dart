import 'package:flutter/material.dart';
import '../login/login.dart'; // LoginScreen 경로 추가

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  final VoidCallback? onLogoTap; // Yolog 로고 클릭 동작 추가
  final bool automaticallyImplyLeading;
  final Widget? leading; // leading 매개변수 추가

  CommonAppBar({
    required this.isDarkMode,
    required this.toggleTheme,
    this.onLogoTap,
    this.automaticallyImplyLeading = true,
    this.leading, // leading 매개변수 추가
  });

  @override
  Widget build(BuildContext context) {
    // 화면 너비를 기반으로 검색창 너비를 동적으로 설정
    double screenWidth = MediaQuery.of(context).size.width;
    double searchWidth = screenWidth * 0.3; // 기본 너비는 화면의 30%
    if (searchWidth > 500) searchWidth = 500; // 최대 너비 제한
    if (searchWidth < 240) searchWidth = 240; // 최소 너비 제한

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      leading: leading, // leading 속성 설정
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onLogoTap,
            child: Text(
              'Yolog',
              style: TextStyle(
                fontFamily: 'Pretendard', // Pretendard 폰트 적용
                color: Color(0xFF4169E1),
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
          Spacer(), // 여유 공간
          // 검색창
          Container(
            width: searchWidth, // 동적으로 계산된 너비 적용
            child: TextField(
              style: TextStyle(
                fontFamily: 'Pretendard', // Pretendard 폰트 적용
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                hintText: '검색',
                hintStyle: TextStyle(
                  fontFamily: 'Pretendard', // Pretendard 폰트 적용
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
          Spacer(), // 여유 공간
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
              fontFamily: 'Pretendard', // Pretendard 폰트 적용
              color: Color(0xFF4169E1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
