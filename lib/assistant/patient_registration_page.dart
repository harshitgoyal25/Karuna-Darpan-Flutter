import 'package:flutter/material.dart';

class PatientRegistrationPage extends StatelessWidget {
  const PatientRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = ['District', 'CHC', 'PHC', 'SC', 'Village'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Registration'),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Demographic Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...fields.map((field) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextField(decoration: InputDecoration(labelText: field)),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/personal-info');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3E1F99)),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}