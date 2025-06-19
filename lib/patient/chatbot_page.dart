import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(title: const Text('Karuna K Saathi'), backgroundColor: const Color(0xFF6A3BFF)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Search for any medical issue or ask about symptoms'),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(hintText: 'What should I do when...')),
          ],
        ),
      ),
    );
  }
}
