import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final bool isDarkMode;
  final double sidebarWidth; // 사이드바 너비 매개변수 추가

  SidebarWidget({required this.isDarkMode, required this.sidebarWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sidebarWidth, // 사이드바 너비 설정
      color: isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 카테고리 리스트는 그대로 유지
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ['전체보기', '한국', '영국', '일본', '미국'].map((category) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextButton(
                    onPressed: () {
                      // 카테고리 클릭 시 동작
                      print('$category 클릭됨');
                    },
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
