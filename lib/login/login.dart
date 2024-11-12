import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart'; // 회원가입 스크린 경로
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // 구글 아이콘 사용

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  LoginScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  // 로그인 로직
  Future<void> _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("로그인 성공: ${userCredential.user?.email}");
      Navigator.of(context).pop(); // 로그인 성공 시 팝업 닫기
    } catch (e) {
      print("로그인 실패: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("로그인 실패"),
          content: Text("이메일 또는 비밀번호가 잘못되었습니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("확인"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double horizontalPadding = 40.0;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10.0),
        decoration: BoxDecoration(
          color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.close, color: widget.isDarkMode ? Colors.white : Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Yolog',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4169E1),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: '이메일을 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: '비밀번호를 입력하세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: Color(0xFF4169E1),
                      checkColor: Colors.white,
                    ),
                    Text(
                      '로그인 유지',
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('비밀번호 찾기'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4169E1),
              ),
              child: Center(
                child: Text(
                  '이메일 로그인',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SignUpScreen(isDarkMode: widget.isDarkMode),
                    );
                  },
                  child: Text('회원가입'),
                ),
                Text('|', style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {},
                  child: Text('이메일 찾기'),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Text('소셜 로그인'),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.google),
                    onPressed: () {
                      // 구글 로그인 로직
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}