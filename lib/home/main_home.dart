import 'dart:ui';
import 'package:flutter/material.dart';
import '../login/login_screen.dart'; // LoginScreen 경로 추가

class MainHomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  MainHomeScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.15;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 50.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Text(
                        'Yolog',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // 수정된 토글 스위치 추가
                        SimpleToggleSwitch(
                          initialValue: isDarkMode,
                          onToggle: (bool value) {
                            toggleTheme(); // 다크 모드 전환 함수 호출
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
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Expanded(
                            child: SingleChildScrollView(
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
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            onPressed: () {
                              // 스크롤 이동 기능 추가 (필요 시 구현)
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              '더미 콘텐츠 $index',
                              style: TextStyle(
                                fontSize: fontSize,
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontFamily: 'Pretendard',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 크기 조정된 기본 토글 스위치 위젯
class SimpleToggleSwitch extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onToggle;

  SimpleToggleSwitch({required this.initialValue, required this.onToggle});

  @override
  _SimpleToggleSwitchState createState() => _SimpleToggleSwitchState();
}

class _SimpleToggleSwitchState extends State<SimpleToggleSwitch> {
  late bool isToggled;

  @override
  void initState() {
    super.initState();
    isToggled = widget.initialValue;
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
        width: 70,
        height: 35, // 원기둥 높이를 35로 조정하여 안의 원과 맞춤
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.5),
          color: isToggled ? Colors.black : Colors.grey[300], // 검정색으로 설정
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isToggled ? 35.0 : 0.0,
              child: Container(
                width: 35,
                height: 35, // 안의 원 크기
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17.5),
                ),
                child: Center(
                  child: Icon(
                    isToggled ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.black,
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
