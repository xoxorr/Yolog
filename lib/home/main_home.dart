import 'package:flutter/material.dart';
import '../widgets/common_app_bar.dart'; // CommonAppBar 경로 추가

class MainHomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  MainHomeScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double titleFontSize = 20.0; // 제목 폰트 크기
    double horizontalPadding = MediaQuery.of(context).size.width * 0.1; // 좌우 여백

    return Scaffold(
      appBar: CommonAppBar(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
      ),
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ListView(
          children: [
            // 블로그 소개 글 섹션
            SizedBox(height: 20),
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

            // 검색창 및 카테고리 섹션
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1, // 검색창 폭 줄이기
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 검색창 박스 투명으로 변경
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 검색 박스
                        TextField(
                          style: TextStyle(
                            color: widget.isDarkMode ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: widget.isDarkMode ? Colors.white : Colors.black,
                            ),
                            hintText: '검색', // 텍스트 변경
                            hintStyle: TextStyle(
                              color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: widget.isDarkMode ? Colors.grey : Colors.black,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.5), // 흰색 투명으로 변경
                          ),
                        ),
                        SizedBox(height: 20),

                        // 카테고리 리스트 (텍스트 클릭 가능하도록 수정)
                        Column(
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
                                    color: widget.isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16.0, // 원하는 텍스트 크기
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),

                // Best 게시글 섹션 (3개까지만 표시)
                Expanded(
                  flex: 3, // 전체 폭을 채우도록 설정
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Best 게시글',
                        style: TextStyle(
                          color: Color(0xFF4169E1), // 제목 색상 변경
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
                            margin: EdgeInsets.only(bottom: 20.0), // 각 게시글 사이 간격
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
                          color: Color(0xFF4169E1), // 제목 색상 변경
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
                                    backgroundColor:
                                    widget.isDarkMode ? Colors.grey[700] : Colors.grey[400],
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
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // 전체 게시글 섹션
            Text(
              '전체 게시글',
              style: TextStyle(
                color: Color(0xFF4169E1), // 제목 색상 변경
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
              ),
            ),
            SizedBox(height: 10),

            // 전체 게시글 개별 박스
            Column(
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0), // 각 게시글 사이 간격
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: widget.isDarkMode ? Colors.grey[800] : Color(0xFFFFF0E0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '전체 게시글 ${index + 1}',
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
          ],
        ),
      ),
    );
  }
}
