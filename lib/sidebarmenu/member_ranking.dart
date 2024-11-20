import 'package:flutter/material.dart';
import '../widgets/appbar.dart'; // CommonAppBar 경로 수정
import '../widgets/sidebar.dart'; // SidebarWidget 경로 수정

class MemberRankingPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  MemberRankingPage({required this.isDarkMode, required this.toggleTheme});

  @override
  _MemberRankingPageState createState() => _MemberRankingPageState();
}

class _MemberRankingPageState extends State<MemberRankingPage> with SingleTickerProviderStateMixin {
  final double sidebarWidth = 200.0;
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
    Color backgroundColor = widget.isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      appBar: CommonAppBar(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.menu, color: widget.isDarkMode ? Colors.white : Colors.black),
          onPressed: toggleSidebar,
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              SidebarWidget(
                isDarkMode: widget.isDarkMode,
                sidebarWidth: sidebarWidth,
                backgroundColor: backgroundColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      '주목받는 멤버 페이지',
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (!isSidebarVisible)
            GestureDetector(
              onTap: () {
                if (isSidebarVisible) toggleSidebar();
              },
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Stack(
                    children: [
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
                          color: backgroundColor,
                          child: SidebarWidget(
                            isDarkMode: widget.isDarkMode,
                            sidebarWidth: sidebarWidth,
                            backgroundColor: backgroundColor,
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
