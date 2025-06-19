import 'package:flutter/material.dart';

class HealthHistoryPage extends StatelessWidget {
  const HealthHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
          title: const Text('Health History'),
          backgroundColor: const Color(0xFF6A3BFF)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('2 June, 2025'),
          ListTile(title: Text('Monthly Health Checkup - ABC Clinic')),
          Text('13 May, 2025'),
          ListTile(title: Text('Emergency Checkup - AC Hospital')),
          Text('2 May, 2025'),
          ListTile(title: Text('Monthly Health Checkup - ABC Clinic')),
        ],
      ),
    );
  }
}
