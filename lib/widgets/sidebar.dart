import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final bool isDarkMode;
  final double sidebarWidth;
  final Color backgroundColor; // 배경색 추가

  SidebarWidget({
    required this.isDarkMode,
    required this.sidebarWidth,
    required this.backgroundColor, // 배경색 받기
  });

  @override
  Widget build(BuildContext context) {
    // 기존 및 추가된 사이드바 항목 리스트
    List<Map<String, dynamic>> sidebarItems = [
      {
        'category': '내 콘텐츠',
        'items': [
          {'name': '홈 피드', 'icon': Icons.home},
          {'name': '인기 콘텐츠', 'icon': Icons.trending_up},
          {'name': '북마크', 'icon': Icons.bookmark},
          {'name': '히스토리', 'icon': Icons.history},
        ],
      },
      {
        'category': '게시물 관리',
        'items': [
          {'name': '게시물 작성', 'icon': Icons.create},
          {'name': '내 게시물 관리', 'icon': Icons.settings},
        ],
      },
      {
        'category': '탐색 및 소셜',
        'items': [
          {'name': '팔로우 피드', 'icon': Icons.people},
          {'name': '태그 탐색', 'icon': Icons.tag},
        ],
      },
      {
        'category': '알림',
        'items': [
          {'name': '댓글 알림', 'icon': Icons.comment},
          {'name': '좋아요 알림', 'icon': Icons.thumb_up},
          {'name': '팔로우 알림', 'icon': Icons.person_add},
        ],
      },
      {
        'category': '설정',
        'items': [
          {'name': '프로필 설정', 'icon': Icons.person},
          {'name': '알림 설정', 'icon': Icons.notifications},
          {'name': '테마 변경', 'icon': Icons.brightness_6},
        ],
      },
      {
        'category': '안내',
        'items': [
          {'name': '가이드북', 'icon': Icons.book},
          {'name': '업데이트', 'icon': Icons.system_update},
          {'name': '고객센터', 'icon': Icons.support_agent},
        ],
      },
    ];

    return Container(
      width: sidebarWidth,
      color: backgroundColor, // 배경색 설정
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 사이드바 항목 생성
          ...sidebarItems.map((section) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Text(
                    section['category'],
                    style: TextStyle(
                      color: Color(0xFF4169E1), // 카테고리 제목 색상 설정
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
                ...section['items'].map<Widget>((item) {
                  return ListTile(
                    leading: Icon(item['icon'], color: isDarkMode ? Colors.white : Colors.black),
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                    onTap: () {
                      // 각 항목 클릭 시 동작 추가
                    },
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
