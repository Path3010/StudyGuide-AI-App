import 'package:flutter/material.dart';

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
    return Container(
      width: 150, // Fixed width for all buttons to maintain uniform size
      child: OutlinedButton.icon(
        onPressed: () {
          print('$text button pressed');
        },
        icon: Icon(icon, color: color, size: 20),
        label: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          side: const BorderSide(color: Color(0x33FFFFFF), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.transparent,
        ),
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
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
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
                    // Use a Wrap widget with alignment logic
                    Wrap(
                      spacing: 12, // Space between buttons horizontally
                      runSpacing: 16, // Space between rows
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
                        // The "Extract" button will be centered in the last row
                        Align(
                          alignment: Alignment.center,
                          child: buildIconButton(
                            text: 'Extract',
                            icon: Icons.content_copy,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 72,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        focusNode: _textFieldFocusNode,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hintText: 'Ask anything',
                          hintStyle: TextStyle(color: Color(0xB3FFFFFF)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.upload_file,
                              color: Colors
                                  .white), // Replaced mic icon with upload document icon
                          onPressed: () {
                            print('Upload document pressed');
                          },
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
            ),
          ],
        ),
      ),
    );
  }
}