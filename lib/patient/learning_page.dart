import 'package:flutter/material.dart';

class PatientLearningPage extends StatelessWidget {
  const PatientLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(title: const Text('Learning'), backgroundColor: const Color(0xFF6A3BFF)),
      body: Column(
        children: [
          ListTile(title: const Text('FAQs'), onTap: () {}),
          ListTile(title: const Text('Chatbot'), onTap: () => Navigator.pushNamed(context, '/chatbot')),
          ListTile(title: const Text('Videos'), onTap: () {}),
        ],
      ),
    );
  }
}