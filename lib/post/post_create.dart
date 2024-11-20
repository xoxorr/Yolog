import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../widgets/appbar.dart'; // CommonAppBar 경로 추가
import '../widgets/sidebar.dart'; // SidebarWidget 경로 추가

class PostCreatePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  PostCreatePage({required this.isDarkMode, required this.toggleTheme});

  @override
  _PostCreatePageState createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final double sidebarWidth = 200.0;
  final quill.QuillController _controller = quill.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  List<File> _videos = [];

  // 이미지 및 동영상 업로드 함수
  Future<void> _pickMedia(bool isImage) async {
    if (isImage) {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _images.addAll(pickedFiles.map((file) => File(file.path)));
        });
      }
    } else {
      final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        setState(() {
          _videos.add(File(pickedVideo.path));
        });
      }
    }
  }

  // Firebase Storage에 이미지 및 동영상 업로드
  Future<void> _uploadMedia() async {
    try {
      for (var image in _images) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('uploads/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}');
        await storageRef.putFile(image);
      }
      for (var video in _videos) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('uploads/videos/${DateTime.now().millisecondsSinceEpoch}_${video.path.split('/').last}');
        await storageRef.putFile(video);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('미디어 업로드 완료')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('미디어 업로드 실패: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        isDarkMode: widget.isDarkMode,
        toggleTheme: widget.toggleTheme,
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      ),
      body: Row(
        children: [
          SidebarWidget(
            isDarkMode: widget.isDarkMode,
            sidebarWidth: sidebarWidth,
            backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
          ),
          Expanded(
            child: Container(
              color: widget.isDarkMode ? Colors.black : Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '글쓰기',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'Pretendard',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // 제목 입력
                  TextField(
                    controller: _titleController,
                    maxLength: 150,
                    decoration: InputDecoration(
                      hintText: '제목을 입력하세요 (최대 150자)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 16.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.isDarkMode ? Colors.white : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: quill.QuillEditor.basic(
                        controller: _controller,
                        focusNode: FocusNode(),
                        // 글쓰기 가능하도록 설정
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // 이모티콘 삽입 버튼
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            _controller.document.insert(
                              _controller.selection.baseOffset,
                              emoji.emoji,
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  // 이미지 및 동영상 업로드 버튼
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _pickMedia(true),
                        icon: Icon(Icons.image),
                        label: Text('이미지 업로드'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () => _pickMedia(false),
                        icon: Icon(Icons.video_library),
                        label: Text('동영상 업로드'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _uploadMedia,
        child: Icon(Icons.save),
        backgroundColor: Color(0xFF4169E1),
      ),
    );
  }
}
