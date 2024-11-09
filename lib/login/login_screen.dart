import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        backgroundColor: Color(0xFF003366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '이메일 주소',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 로그인 로직 추가
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366),
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                '로그인',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // 비밀번호 찾기 로직 추가
              },
              child: Text('비밀번호 찾기', style: TextStyle(color: Colors.blue)),
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // 구글 로그인 로직 추가
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              icon: Image.asset(
                'assets/google_logo.png',
                height: 24.0,
              ),
              label: Text(
                '구글 로그인',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
