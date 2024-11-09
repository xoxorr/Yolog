import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
        backgroundColor: Color(0xFF003366), // 지정된 색상
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일 주소'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 로그인 로직 추가 필요
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366), // 버튼 색상
              ),
              child: Text('로그인'),
            ),
            TextButton(
              onPressed: () {
                // 회원가입 로직 추가 필요
              },
              child: Text('신규회원가입'),
            ),
            TextButton(
              onPressed: () {
                // 비밀번호 찾기 로직 추가 필요
              },
              child: Text('비밀번호 찾기'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // 구글 로그인 로직 추가 필요
              },
              icon: Icon(Icons.login, color: Colors.black),
              label: Text(
                '구글 로그인',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 흰색 배경
              ),
            ),
          ],
        ),
      ),
    );
  }
}
