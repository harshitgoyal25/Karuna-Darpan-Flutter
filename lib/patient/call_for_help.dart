import 'package:flutter/material.dart';

class CallForHelpPage extends StatelessWidget {
  const CallForHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ['K SAATHI', 'AMBULANCE', 'TELE MANAS'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Call For Help',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          ...options.map((title) => Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  title: Text(title, style: const TextStyle(fontSize: 16)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle help option tap
                  },
                ),
              )),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Handle emergency tap
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('EMERGENCY',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
