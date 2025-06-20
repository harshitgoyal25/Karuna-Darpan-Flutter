import 'package:flutter/material.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Patient Profile',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          const Text(
            'Aarjoo Dahiya\nAge: 21  |  Gender: Female',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/session-time'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3E1F99),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Please verify location'),
          ),
          const Divider(height: 40),
          const Text(
            'Add Complications',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('• Severity/Grade'),
          const Text('• Date of Onset'),
          const Text('• Clinical Notes'),
          const Divider(height: 40),
          const Text(
            'Do you want the assistant to measure vitals?',
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('Yes'),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () {},
                child: const Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
