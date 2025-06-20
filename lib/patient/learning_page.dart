import 'package:flutter/material.dart';

class PatientLearningPage extends StatelessWidget {
  const PatientLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'title': 'FAQs', 'route': null},
      {'title': 'Chatbot', 'route': '/chatbot'},
      {'title': 'Videos', 'route': null},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Learning', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(option['title']!, style: const TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                if (option['route'] != null) {
                  Navigator.pushNamed(context, option['route']!);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
