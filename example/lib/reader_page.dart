import 'package:easy_reader/easy_reader.dart';
import 'package:flutter/material.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage> {
  final reader = EasyReader(
    blocks: [
      TextBlock(index: 0, data: 'Hello, World!'),
      ImageBlock(
        index: 1,
        data: Uri.parse('https://example.com/image.png'),
        size: const Size(100, 100),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green.withOpacity(0.3), width: 16),
        ),
        child: ReaderView(reader: reader),
      ),
    );
  }
}
