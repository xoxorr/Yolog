import 'package:flutter/material.dart';
import '../widgets/appbar.dart'; // CommonAppBar 경로 추가
import '../widgets/sidebar.dart'; // SidebarWidget 경로 추가

class SupportCenterPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  SupportCenterPage({required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    double sidebarWidth = 200.0;

    return Scaffold(
      appBar: CommonAppBar(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: Row(
        children: [
          SidebarWidget(
            isDarkMode: isDarkMode,
            sidebarWidth: sidebarWidth,
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          ),
          Expanded(
            child: Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: Center(
                child: Text(
                  '고객센터 페이지',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/postCreate');
        },
        child: Icon(Icons.create),
        backgroundColor: Color(0xFF4169E1),
      ),
    );
  }
}
