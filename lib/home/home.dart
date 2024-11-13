import 'package:flutter/material.dart';
import '../widgets/appbar.dart'; // CommonAppBar 경로 추가
import '../widgets/sidebar.dart'; // SidebarWidget 경로 추가

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  HomeScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final double sidebarWidth = 240.0;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool isSidebarVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(_animationController);
  }

  void toggleSidebar() {
    setState(() {
      isSidebarVisible = !isSidebarVisible;
      if (isSidebarVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      appBar: CommonAppBar(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white, // backgroundColor 추가
        leading: isLargeScreen
            ? null
            : IconButton(
          icon: Icon(Icons.menu, color: widget.isDarkMode ? Colors.white : Colors.black),
          onPressed: toggleSidebar,
        ),
      ),
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      body: Stack(
        children: [
          // 메인 콘텐츠
          Row(
            children: [
              if (isLargeScreen)
                SidebarWidget(
                  isDarkMode: widget.isDarkMode,
                  sidebarWidth: sidebarWidth,
                  backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      // 이미지 섹션
                      Center(
                        child: Container(
                          width: double.infinity,
                          height: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('asset/Pngtreeworldtravel1185773.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Best 게시글 섹션
                      Text(
                        'Best 게시글',
                        style: TextStyle(
                          color: Color(0xFF4169E1),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                      SizedBox(height: 10),
                      // Best 게시글 리스트
                      Column(
                        children: List.generate(3, (index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: widget.isDarkMode ? Colors.grey[800] : Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Best 게시글 ${index + 1}',
                                  style: TextStyle(
                                    color: widget.isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '이곳에 게시글 내용을 입력하세요. 내용이 길 경우에도 디자인이 유지되도록 적절하게 작성됩니다...',
                                  style: TextStyle(
                                    color: widget.isDarkMode ? Colors.grey[300] : Colors.black,
                                    fontSize: 14.4,
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
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(10, (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 16.0),
                              width: 120,
                              height: 140,
                              decoration: BoxDecoration(
                                color: widget.isDarkMode ? Colors.grey[800] : Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
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
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '사용자 ${index + 1}',
                                    style: TextStyle(
                                      color: widget.isDarkMode ? Colors.white : Colors.black,
                                      fontSize: 16.0,
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
                      // "전체 보기" 섹션
                      Text(
                        '전체 보기',
                        style: TextStyle(
                          color: Color(0xFF4169E1),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: List.generate(5, (index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: widget.isDarkMode ? Colors.grey[800] : Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '게시글 ${index + 1}',
                                  style: TextStyle(
                                    color: widget.isDarkMode ? Colors.white : Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '이곳에 더미 게시글 내용을 입력하세요. 내용이 길 경우에도 디자인이 유지되도록 적절하게 작성됩니다...',
                                  style: TextStyle(
                                    color: widget.isDarkMode ? Colors.grey[300] : Colors.black,
                                    fontSize: 14.4,
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
          // 슬라이드 사이드바
          if (!isLargeScreen)
            GestureDetector(
              onTap: () {
                if (isSidebarVisible) toggleSidebar();
              },
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Stack(
                    children: [
                      // 어두운 배경
                      if (isSidebarVisible)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          width: sidebarWidth,
                          color: widget.isDarkMode ? Colors.black : Colors.white,
                          child: SidebarWidget(
                            isDarkMode: widget.isDarkMode,
                            sidebarWidth: sidebarWidth,
                            backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
