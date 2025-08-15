import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyGuide AI',
      debugShowCheckedModeBanner: false,
      home: const HomescreenWidget(),
    );
  }
}

class HomescreenWidget extends StatefulWidget {
  const HomescreenWidget({super.key});

  @override
  State<HomescreenWidget> createState() => _HomescreenWidgetState();
}

class _HomescreenWidgetState extends State<HomescreenWidget> {
  bool _isUploadingImage = false;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  Widget buildIconButton({
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return OutlinedButton.icon(
      onPressed: () {
        print('$text button pressed');
      },
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(120, 48),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        side: const BorderSide(color: Color(0x33FFFFFF), width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1A1A),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              print('Menu pressed');
            },
          ),
          title: const Text(
            'StudyGuide AI',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onPressed: () {
                  print('Sign up pressed');
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 40),
                      child: Text(
                        'What can I help with?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Dynamic buttons using Wrap
                    Wrap(
                      spacing: 12,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        buildIconButton(
                          text: 'Summarize',
                          icon: Icons.description,
                          color: const Color(0xFFF59E0B),
                        ),
                        buildIconButton(
                          text: 'Mindmap',
                          icon: Icons.lightbulb_outline,
                          color: const Color(0xFFFCD34D),
                        ),
                        buildIconButton(
                          text: 'Flashcards',
                          icon: Icons.school,
                          color: const Color(0xFF60A5FA),
                        ),
                        buildIconButton(
                          text: 'Pop Quiz',
                          icon: Icons.quiz,
                          color: const Color(0xFF60A5FA),
                        ),
                        buildIconButton(
                          text: 'Extract',
                          icon: Icons.content_copy,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ],
                    ),
                    // ...existing code...
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isUploadingImage)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Uploading image...',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            focusNode: _textFieldFocusNode,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            minLines: 1,
                            maxLines: 6,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: 'Ask anything',
                              hintStyle: TextStyle(color: Color(0xB3FFFFFF)),
                              border: InputBorder.none,
                              isCollapsed: false,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.upload_file,
                                color: Colors.white,
                              ),
                              onPressed: () => _showUploadBottomSheet(context),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.send, color: Colors.black),
                                onPressed: () {
                                  print('Send pressed');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: const Color(0xFF232323),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text('Take a photo', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.pop(context);
                  setState(() => _isUploadingImage = true);
                  final picker = ImagePicker();
                  await picker.pickImage(source: ImageSource.camera);
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() => _isUploadingImage = false);
                },
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text('Pick from gallery', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.pop(context);
                  setState(() => _isUploadingImage = true);
                  final picker = ImagePicker();
                  await picker.pickImage(source: ImageSource.gallery);
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() => _isUploadingImage = false);
                },
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              ListTile(
                leading: const Icon(Icons.insert_drive_file, color: Colors.white),
                title: const Text('Browse documents', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  Navigator.pop(context);
                  await FilePicker.platform.pickFiles();
                },
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ],
          ),
        );
      },
    );
  }
}
