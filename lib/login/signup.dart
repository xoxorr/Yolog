import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // 구글 아이콘 사용

class SignUpScreen extends StatefulWidget {
  final bool isDarkMode;

  SignUpScreen({required this.isDarkMode});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // 회원가입 로직
  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("오류"),
          content: Text("비밀번호가 일치하지 않습니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("확인"),
            ),
          ],
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("회원가입 성공: ${userCredential.user?.email}");
      Navigator.of(context).pop(); // 회원가입 성공 시 팝업 닫기
    } catch (e) {
      print("회원가입 실패: $e");
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("회원가입 실패"),
          content: Text("오류가 발생했습니다. 다시 시도해 주세요."),
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

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(), // 팝업 외부 클릭 시 닫기
      child: Dialog(
        backgroundColor: Colors.transparent, // 배경을 투명하게 설정
        child: GestureDetector(
          onTap: () {}, // 팝업 내부 클릭은 무시
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
                // 닫기 버튼
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.close, color: widget.isDarkMode ? Colors.white : Colors.black),
                    onPressed: () => Navigator.of(context).pop(), // 팝업 닫기
                  ),
                ),
                SizedBox(height: 10),

                // 로고 및 회원가입 텍스트
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Yolog',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4169E1), // 파란색 코드 적용
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '회원가입',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // 이메일 입력 필드
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

                // 비밀번호 입력 필드
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

                // 비밀번호 확인 필드
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: '비밀번호 확인',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // 회원가입 버튼
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1), // 파란색 버튼
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // 아이디/비밀번호 찾기
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 아이디 찾기 로직
                      },
                      child: Text(
                        '아이디 찾기',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        ),
                      ),
                    ),
                    Text('|', style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        // 비밀번호 찾기 로직
                      },
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // 소셜 로그인
                Center(
                  child: Column(
                    children: [
                      Text(
                        '소셜 로그인',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                          fontSize: fontSize * 0.9,
                        ),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.google, size: 40.0, color: Colors.grey),
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
        ),
      ),
    );
  }
}