import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            color: const Color(0xFF6A3BFF),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 12),
            child: const Text('Patient Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/health-history'),
              child: const Text('Health History')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/symptom-tracker'),
              child: const Text('Symptom Tracker')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/call-for-help'),
              child: const Text('Call For Help')),
          ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/patient-learning'),
              child: const Text('Learning')),
        ],
      ),
    );
  }
}
