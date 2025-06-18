import 'package:flutter/material.dart';

class SessionTimePage extends StatelessWidget {
  const SessionTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Time Log and Geo-Verification'),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Confirm visit duration and location', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 10),
          const Text('00:32:17', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('End Session')),
              const SizedBox(width: 10),
              OutlinedButton(onPressed: () {}, child: const Text('Pause')),
            ],
          ),
          const SizedBox(height: 20),
          const Icon(Icons.location_on, size: 50, color: Colors.red),
          const Text('On-site', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}