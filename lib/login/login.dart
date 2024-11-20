import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home/home.dart'; // HomeScreen의 경로를 프로젝트에 맞게 수정하세요

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  LoginScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();
  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscureLoginPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _loginEmailError;
  String? _loginPasswordError;
  String? _signUpEmailError;
  String? _signUpPasswordError;
  String? _confirmPasswordError;
  String? _passwordMatchMessage;
  String? _emailSentMessage;

  void _validateEmail(String value, {bool isSignUp = false}) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      setState(() {
        if (isSignUp) {
          _signUpEmailError = '이메일 형식을 지켜주세요!';
        } else {
          _loginEmailError = '이메일 형식을 지켜주세요!';
        }
      });
    } else {
      setState(() {
        if (isSignUp) {
          _signUpEmailError = null;
        } else {
          _loginEmailError = null;
        }
      });
    }
  }

  void _validatePassword(String value, {bool isSignUp = false}) {
    if (value.isEmpty) {
      setState(() {
        if (isSignUp) {
          _signUpPasswordError = '비밀번호를 입력해주세요!';
        } else {
          _loginPasswordError = '비밀번호를 입력해주세요!';
        }
      });
    } else {
      setState(() {
        if (isSignUp) {
          _signUpPasswordError = null;
        } else {
          _loginPasswordError = null;
        }
      });
    }
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _confirmPasswordError = '비밀번호 확인을 입력해주세요!';
        _passwordMatchMessage = null;
      });
    } else if (value != _signUpPasswordController.text) {
      setState(() {
        _confirmPasswordError = '비밀번호가 일치하지 않습니다!';
        _passwordMatchMessage = null;
      });
    } else {
      setState(() {
        _confirmPasswordError = null;
        _passwordMatchMessage = '비밀번호가 일치합니다!';
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.white,
        title: Text(
          '오류',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          message,
          style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              '확인',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _login() async {
    _validateEmail(_emailController.text);
    _validatePassword(_loginPasswordController.text);

    if (_loginEmailError != null || _loginPasswordError != null) {
      _showErrorDialog('이메일과 비밀번호를 올바르게 입력해주세요.');
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _loginPasswordController.text,
      );
      // 로그인 성공 시 홈 화면으로 전환
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(isDarkMode: widget.isDarkMode, toggleTheme: widget.toggleTheme)),
      );
    } catch (e) {
      _showErrorDialog('로그인 실패: ${e.toString()}');
    }
  }

  Future<void> _sendVerificationEmail() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _signUpEmailController.text,
        password: _signUpPasswordController.text,
      );
      User? user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        setState(() {
          _emailSentMessage = '이메일 인증 메일이 전송되었습니다.';
        });
      }
    } catch (e) {
      setState(() {
        _emailSentMessage = '이메일 전송 실패: ${e.toString()}';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _loginPasswordController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      onChanged: (value) => _validateEmail(value),
      onSubmitted: (_) => _login(), // 엔터로 로그인 실행
      style: TextStyle(
        color: widget.isDarkMode ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: '이메일을 입력하세요',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        filled: true,
        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
        errorText: _loginEmailError,
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _loginPasswordController,
      obscureText: _obscureLoginPassword,
      onChanged: (value) => _validatePassword(value),
      onSubmitted: (_) => _login(), // 엔터로 로그인 실행
      style: TextStyle(
        color: widget.isDarkMode ? Colors.white : Colors.black,
      ),
      decoration: InputDecoration(
        hintText: '비밀번호를 입력하세요',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        filled: true,
        fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
        errorText: _loginPasswordError,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureLoginPassword ? Icons.visibility : Icons.visibility_off,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            setState(() {
              _obscureLoginPassword = !_obscureLoginPassword;
            });
          },
        ),
      ),
    );
  }

  // 새로운 회원가입 다이얼로그를 추가하는 메서드
  void _showSignUpDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 400.0,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  '회원가입 후 다양한 서비스를 즐겨보세요.',
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _signUpEmailController,
                  onChanged: (value) => _validateEmail(value, isSignUp: true),
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    errorText: _signUpEmailError,
                    filled: true,
                    fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _signUpPasswordController,
                  obscureText: true,
                  onChanged: (value) => _validatePassword(value, isSignUp: true),
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    errorText: _signUpPasswordError,
                    filled: true,
                    fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  onChanged: _validateConfirmPassword,
                  style: TextStyle(
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: '비밀번호 확인',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    errorText: _confirmPasswordError,
                    filled: true,
                    fillColor: widget.isDarkMode ? Colors.grey[800] : Colors.white,
                  ),
                ),
                if (_passwordMatchMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      _passwordMatchMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _sendVerificationEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1),
                    minimumSize: Size(double.infinity, 50.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('회원가입', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400.0,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                SizedBox(height: 16),
                _buildEmailField(),
                SizedBox(height: 8),
                _buildPasswordField(),
                SizedBox(height: 12),
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
                      onPressed: () {}, // 비밀번호 찾기 로직
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          color: widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4169E1),
                  ),
                  child: Center(
                    child: Text('로그인', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: _showSignUpDialog,
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.close, color: widget.isDarkMode ? Colors.white : Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
