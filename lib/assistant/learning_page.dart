import 'package:flutter/material.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = ['ChatBot', 'F&Qs', 'Articles', 'Videos'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning'),
        backgroundColor: const Color(0xFF3E1F99),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: Column(
        children: sections
            .map((section) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    color: Colors.grey.shade200,
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: Text(section,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ))
            .toList(),
      ),
    );
  }
}