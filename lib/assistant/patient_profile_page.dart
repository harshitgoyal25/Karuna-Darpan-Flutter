import 'package:flutter/material.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Aarjoo Dahiya Age - 21 Gender - Female', style: TextStyle(fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/session-time'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3E1F99)),
              child: const Text('Please verify location'),
            ),
          ),
          const Divider(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Add Complications', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Severity/Grade'),
                Text('Date of Onset'),
                Text('Clinical Notes'),
              ],
            ),
          ),
          const Divider(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Do you want the assistant to measure vitals?'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                OutlinedButton(onPressed: () {}, child: Text('Yes')),
                SizedBox(width: 16),
                OutlinedButton(onPressed: () {}, child: Text('No')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}