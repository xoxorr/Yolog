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
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
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
          Row(
            children: [
              if (isLargeScreen)
                SidebarWidget(
                  isDarkMode: widget.isDarkMode,
                  sidebarWidth: sidebarWidth,
                  backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
                ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    // 이미지 섹션 (1/3 크기로 더 줄임)
                    Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 5, // 이미지 비율 설정 (더 줄임)
                        child: Container(
                          height: 100.0, // 이미지 높이를 더 줄임
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('asset/Pngtreeworldtravel1185773.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Best 게시글 섹션
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Best 게시글',
                        style: TextStyle(
                          color: Color(0xFF4169E1),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    // 전체 보기 섹션
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '전체 보기',
                        style: TextStyle(
                          color: Color(0xFF4169E1),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pretendard',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 16.0,
                        runSpacing: 16.0,
                        alignment: WrapAlignment.center,
                        children: List.generate(10, (index) {
                          return PostCard(
                            isDarkMode: widget.isDarkMode,
                            title: '게시글 ${index + 1}',
                            description: '이곳에 게시글 내용을 입력하세요...',
                          );
                        }),
                      ),
                    ),
                  ],
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

class PostCard extends StatelessWidget {
  final bool isDarkMode;
  final String title;
  final String description;

  PostCard({required this.isDarkMode, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 304.0,
      height: 374.0,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white.withOpacity(0.8),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              image: DecorationImage(
                image: AssetImage('asset/KakaoTalk20241113154504706.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[300] : Colors.black,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
