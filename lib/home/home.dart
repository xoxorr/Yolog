import 'package:flutter/material.dart';
import '../widgets/appbar.dart'; // CommonAppBar 경로 추가
import '../widgets/sidebar.dart'; // SidebarWidget 경로 추가

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  HomeScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Scaffold 키 생성

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double titleFontSize = 20.0; // 제목 폰트 크기

    // 화면 너비에 따라 사이드바 가시성 설정
    bool isSidebarVisible = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      key: _scaffoldKey, // Scaffold 키 설정
      appBar: CommonAppBar(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
        // 사이드바가 숨겨졌을 때만 햄버거 메뉴 아이콘 표시
        leading: isSidebarVisible
            ? null
            : IconButton(
                icon: Icon(Icons.menu, color: widget.isDarkMode ? Colors.white : Colors.black),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(), // Drawer 열기
              ),
      ),
      drawer: isSidebarVisible
          ? null
          : Drawer(
              child: SidebarWidget(isDarkMode: widget.isDarkMode),
            ),
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      body: Row(
        children: [
          // 사이드바가 보일 때만 표시
          if (isSidebarVisible) SidebarWidget(isDarkMode: widget.isDarkMode),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // 블로그 소개 글 섹션
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: widget.isDarkMode ? Colors.grey[800] : Color(0xFFFFF0E0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        'Yolog는 여행을 사랑하는 사람들을 위한 플랫폼입니다. 여행 경험을 공유하고, 다양한 여행지와 활동에 대한 이야기를 기록할 수 있습니다.',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                          fontSize: fontSize,
                          fontFamily: 'Pretendard',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Best 게시글 섹션
                  Text(
                    'Best 게시글',
                    style: TextStyle(
                      color: Color(0xFF4169E1),
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(height: 10),

                  // Best 게시글 개별 박스 (3개만)
                  Column(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: widget.isDarkMode ? Colors.grey[800] : Color(0xFFFFF0E0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Best 게시글 ${index + 1}',
                              style: TextStyle(
                                color: widget.isDarkMode ? Colors.white : Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '이곳에 게시글 내용을 입력하세요. 내용이 길 경우에도 디자인이 유지되도록 적절하게 작성됩니다...',
                              style: TextStyle(
                                color: widget.isDarkMode ? Colors.grey[300] : Colors.black,
                                fontSize: fontSize * 0.9,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),

                  // 주목받는 멤버 섹션
                  Text(
                    '주목받는 멤버',
                    style: TextStyle(
                      color: Color(0xFF4169E1),
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(height: 10),

                  // 주목받는 멤버 목록
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) {
                        return Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 120,
                          height: 140,
                          decoration: BoxDecoration(
                            color: widget.isDarkMode ? Colors.grey[800] : Color(0xFFFFF0E0),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: widget.isDarkMode ? Colors.grey[700] : Colors.grey[400],
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '사용자 ${index + 1}',
                                style: TextStyle(
                                  color: widget.isDarkMode ? Colors.white : Colors.black,
                                  fontSize: fontSize,
                                  fontFamily: 'Pretendard',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 20),

                  // "전체 보기" 제목 섹션
                  Text(
                    '전체 보기',
                    style: TextStyle(
                      color: Color(0xFF4169E1),
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pretendard',
                    ),
                    textAlign: TextAlign.left, // 왼쪽 정렬
                  ),
                  SizedBox(height: 10),

                  // 더미 게시글 목록
                  Column(
                    children: List.generate(5, (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: widget.isDarkMode ? Colors.grey[800] : Color(0xFFFFF0E0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '게시글 ${index + 1}',
                              style: TextStyle(
                                color: widget.isDarkMode ? Colors.white : Colors.black,
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '이곳에 더미 게시글 내용을 입력하세요. 내용이 길 경우에도 디자인이 유지되도록 적절하게 작성됩니다...',
                              style: TextStyle(
                                color: widget.isDarkMode ? Colors.grey[300] : Colors.black,
                                fontSize: fontSize * 0.9,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
