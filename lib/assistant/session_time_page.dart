import 'package:flutter/material.dart';

class SessionTimePage extends StatelessWidget {
  const SessionTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Session Time Log and Geo-Verification',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        children: [
          const Center(
            child: Text(
              'Confirm visit duration and location',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              '00:32:17',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('End Session', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  side: const BorderSide(color: Color(0xFF3E1F99)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Pause', style: TextStyle(color: Color(0xFF3E1F99))),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Center(
            child: Icon(Icons.location_on, size: 50, color: Colors.red),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text('On-site', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
