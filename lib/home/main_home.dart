import 'package:flutter/material.dart';
import '../login/login_screen.dart'; // LoginScreen 경로 추가

// 다크 모드 스위치 위젯
class DarkModeSwitch extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggle;

  DarkModeSwitch({required this.isDarkMode, required this.onToggle});

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.isDarkMode;
  }

  void _toggleSwitch() {
    setState(() {
      isToggled = !isToggled;
    });
    widget.onToggle(isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: isToggled ? Colors.black : Colors.grey[300],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isToggled ? 30.0 : 0.0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Center(
                  child: Icon(
                    isToggled ? Icons.dark_mode : Icons.light_mode,
                    color: isToggled ? Colors.black : Colors.yellow,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MainHomeScreen 위젯
class MainHomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  MainHomeScreen({required this.isDarkMode, required this.toggleTheme});

  final ScrollController _scrollController = ScrollController();

  void _scrollToNext() {
    double offset = _scrollController.offset + 140.0;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToPrevious() {
    double offset = _scrollController.offset - 140.0;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.15;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Yolog',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Row(
                children: [
                  DarkModeSwitch(
                    isDarkMode: isDarkMode,
                    onToggle: (bool value) {
                      toggleTheme();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: isDarkMode
            ? Colors.black.withOpacity(0.7)
            : Color(0xFFFFFFF0).withOpacity(0.7),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  'Yolog는 여행을 사랑하는 사람들을 위한 플랫폼입니다. 여행 경험을 공유하고, 다양한 여행지와 활동에 대한 이야기를 기록할 수 있습니다. Yolog는 사용자 간의 소통과 영감을 주고받는 공간을 제공합니다.',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: fontSize,
                    fontFamily: 'Pretendard',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '최근 뜨는 게시글',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Pretendard',
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                '게시글이 아직 없습니다.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: fontSize,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '주목받는 멤버',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Pretendard',
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: _scrollToPrevious,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 배경 투명 설정
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(10, (index) {
                        return Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: 120,
                          height: 140,
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[400],
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
                                  color: isDarkMode ? Colors.white : Colors.black,
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
                ),
                GestureDetector(
                  onTap: _scrollToNext,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 배경 투명 설정
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            // 추가된 전체보기 섹션
            SizedBox(height: 20),
            Text(
              '전체보기',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Pretendard',
              ),
            ),
            SizedBox(height: 10),
            ...List.generate(10, (index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(4, 4),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '# 카테고리 ${index + 1}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '더미 콘텐츠 제목 ${index + 1}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '더미 설명이 들어갑니다. 스크롤 테스트를 위해 생성된 내용입니다...',
                      style: TextStyle(
                        color: isDarkMode ? Colors.grey[400] : Colors.black54,
                        fontSize: 14.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '작성자 ${index + 1}',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.black87,
                            fontSize: 12.0,
                          ),
                        ),
                        Text(
                          '몇 분 전',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white54 : Colors.grey[600],
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
