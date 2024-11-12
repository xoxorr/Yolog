import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Text('내 콘텐츠', style: TextStyle(color: Colors.white)),
          ),
          ListTile(title: Text('홈 피드'), onTap: () {}),
          ListTile(title: Text('오늘의 브리핑'), onTap: () {}),
        ],
      ),
    );
  }
}
