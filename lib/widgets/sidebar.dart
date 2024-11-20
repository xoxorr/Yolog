import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final bool isDarkMode;
  final double sidebarWidth;
  final Color backgroundColor;

  SidebarWidget({
    required this.isDarkMode,
    required this.sidebarWidth,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // 사이드바 항목 리스트
    List<Map<String, dynamic>> sidebarItems = [
      {
        'category': '내 콘텐츠',
        'items': [
          {
            'name': '홈 피드',
            'icon': Icons.home,
            'onTap': () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          },
          {
            'name': '인기 콘텐츠',
            'icon': Icons.trending_up,
            'onTap': () {
              Navigator.of(context).pushNamed('/trendingContent');
            },
          },
          {
            'name': '북마크',
            'icon': Icons.bookmark,
            'onTap': () {
              Navigator.of(context).pushNamed('/bookmark');
            },
          },
          {
            'name': '히스토리',
            'icon': Icons.history,
            'onTap': () {
              Navigator.of(context).pushNamed('/history');
            },
          },
        ],
      },
      {
        'category': '탐색 및 소셜',
        'items': [
          {
            'name': '주목받는 멤버',
            'icon': Icons.star,
            'onTap': () {
              Navigator.of(context).pushNamed('/featuredMembers');
            },
          },
          {
            'name': '팔로우 피드',
            'icon': Icons.people,
            'onTap': () {
              Navigator.of(context).pushNamed('/followFeed');
            },
          },
          {
            'name': '태그 탐색',
            'icon': Icons.tag,
            'onTap': () {
              Navigator.of(context).pushNamed('/tagExplore');
            },
          },
        ],
      },
    ];

    List<Map<String, dynamic>> footerItems = [
      {
        'category': '안내',
        'items': [
          {
            'name': '가이드북',
            'icon': Icons.book,
            'onTap': () {
              Navigator.of(context).pushNamed('/guidebook');
            },
          },
          {
            'name': '업데이트',
            'icon': Icons.system_update,
            'onTap': () {
              Navigator.of(context).pushNamed('/update');
            },
          },
          {
            'name': '고객센터',
            'icon': Icons.support_agent,
            'onTap': () {
              Navigator.of(context).pushNamed('/supportCenter');
            },
          },
        ],
      },
    ];

    return Container(
      width: sidebarWidth,
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 상단 사이드바 항목
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...sidebarItems.map((section) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 4.0, left: 16.0), // 여백 줄임
                        child: Text(
                          section['category'],
                          style: TextStyle(
                            color: Color(0xFF4169E1),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                      ...section['items'].map<Widget>((item) {
                        return ListTile(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16.0), // 여백 조정
                          leading: Icon(
                            item['icon'],
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          title: Text(
                            item['name'],
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Pretendard',
                            ),
                          ),
                          onTap: item['onTap'],
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          // 하단 사이드바 항목
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...footerItems.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 4.0, left: 16.0), // 여백 줄임
                      child: Text(
                        section['category'],
                        style: TextStyle(
                          color: Color(0xFF4169E1),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    ...section['items'].map<Widget>((item) {
                      return ListTile(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0), // 여백 조정
                        leading: Icon(
                          item['icon'],
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        title: Text(
                          item['name'],
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                        onTap: item['onTap'],
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
