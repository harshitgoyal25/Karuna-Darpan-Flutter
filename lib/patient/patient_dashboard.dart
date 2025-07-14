import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String patientName = args?['name'] ?? 'Patient';
    final String? patientId =
        args?['patientId'] ?? args?['id']; // ✅ fallback added

    final List<Map<String, dynamic>> otherButtons = [
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
            child: Text(
              patientName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Health History button (custom)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                if (patientId != null) {
                  Navigator.pushNamed(
                    context,
                    '/health-history',
                    arguments: {'patientId': patientId},
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Missing patient ID')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  const Text('Health History', style: TextStyle(fontSize: 16)),
            ),
          ),

          // Other buttons
          ...otherButtons.map((btn) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, btn['route'] as String),
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
