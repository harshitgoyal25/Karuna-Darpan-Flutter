import 'package:flutter/material.dart';

class CallForHelpPage extends StatelessWidget {
  const CallForHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(title: const Text('Call For Help'), backgroundColor: const Color(0xFF6A3BFF)),
      body: Column(
        children: [
          ListTile(title: const Text('K SAATHI'), onTap: () {}),
          ListTile(title: const Text('AMBULANCE'), onTap: () {}),
          ListTile(title: const Text('TELE MANAS'), onTap: () {}),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('EMERGENCY')),
        ],
      ),
    );
  }
}