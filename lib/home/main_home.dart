import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  MainHomeScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: AppBar(
            title: Row(
              children: [
                Text(
                  'Yolog',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pretendard',
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: toggleTheme,
                ),
                TextButton(
                  onPressed: () {},
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
            backgroundColor: isDarkMode ? Colors.black : Color(0xFFFFFFF0),
            elevation: 0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
