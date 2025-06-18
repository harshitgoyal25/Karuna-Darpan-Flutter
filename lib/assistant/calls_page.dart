import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = [
      'General Medicine',
      'General Surgery',
      'Cardiology',
      'Neurology',
      'Orthopedics 🛠️',
      'Pediatrics',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Call'),
        backgroundColor: const Color(0xFF3E1F99),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: departments
            .map((dept) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
                  color: Colors.grey.shade200,
                  child: Text('📝 $dept', style: const TextStyle(fontSize: 16)),
                ))
            .toList(),
      ),
    );
  }
}