import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // 구글 아이콘 사용을 위해 추가

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  // 생성자
  LoginScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true; // 비밀번호 숨기기 상태

  void _handleGoogleSignIn() {
    // 구글 로그인 로직 구현
    print("Google Sign-In 클릭됨");
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 16.0;
    double horizontalPadding = 40.0; // 좌우 폭을 줄이기

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(), // 팝업 외부 클릭 시 닫기
      child: Dialog(
        backgroundColor: Colors.transparent, // 배경을 투명하게 설정
        child: GestureDetector(
          onTap: () {}, // 팝업 내부 클릭은 무시
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3, // 팝업창 폭 줄이기
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.0),
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 팝업 창 크기를 내용에 맞게 설정
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

                // 로고 및 로그인 텍스트
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Yolog', // 제목을 Yolog로 변경
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4169E1), // 파란색 코드 적용
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

                // 이메일 입력 필드
                TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: '이메일을 입력하세요',
                    hintStyle: TextStyle(
                      color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: widget.isDarkMode ? Colors.grey : Colors.black,
                      ),
                    ),
                    filled: true,
                    fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                  ),
                ),
                SizedBox(height: 10),

                // 비밀번호 입력 필드
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, // 비밀번호 숨기기/보이기 상태
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                    hintStyle: TextStyle(
                      color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: widget.isDarkMode ? Colors.grey : Colors.black,
                      ),
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
                          _obscurePassword = !_obscurePassword; // 비밀번호 보이기/숨기기 전환
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // 로그인 유지 및 비밀번호 찾기
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
                          activeColor: Color(0xFF4169E1), // 체크박스 색상 변경
                          checkColor: Colors.white, // 체크 마크 색상
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
                SizedBox(height: 20),

                // 이메일 로그인 버튼
                ElevatedButton(
                  onPressed: () {
                    // 로그인 로직 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1), // 파란색 버튼
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '이메일 로그인', // 텍스트 변경
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // 회원가입 및 이메일 찾기
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // 회원가입 로직
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        ),
                      ),
                    ),
                    Text('|', style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        // 이메일 찾기 로직
                      },
                      child: Text(
                        '이메일 찾기',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // 소셜 로그인 문구 및 구글 로그인 버튼
                Center(
                  child: Column(
                    children: [
                      Text(
                        '소셜 로그인', // 문구 수정
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
                          fontSize: fontSize * 0.9,
                        ),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.google, size: 40.0, color: Colors.grey), // 구글 아이콘
                        onPressed: _handleGoogleSignIn, // 구글 로그인 로직
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
