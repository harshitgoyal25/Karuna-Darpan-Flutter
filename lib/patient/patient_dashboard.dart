import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> buttons = [
      {'title': 'Health History', 'route': '/health-history'},
      {'title': 'Symptom Tracker', 'route': '/symptom-tracker'},
      {'title': 'Call For Help', 'route': '/call-for-help'},
      {'title': 'Learning', 'route': '/patient-learning'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Patient Dashboard',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        elevation: 0,
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF6A3BFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Patient Name',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(height: 24),
          ...buttons.map((btn) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, btn['route']),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      Text(btn['title'], style: const TextStyle(fontSize: 16)),
                ),
              )),
        ],
      ),
    );
  }
}
