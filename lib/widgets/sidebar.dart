import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final bool isDarkMode;

  SidebarWidget({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // 사이드바 너비
      color: isDarkMode ? Colors.black : Colors.white, // 배경색과 동일하게 설정
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 검색 박스
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                hintText: '검색',
                hintStyle: TextStyle(
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
          SizedBox(height: 20),

          // 카테고리 리스트
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
