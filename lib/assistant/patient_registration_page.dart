import 'package:flutter/material.dart';

class PatientRegistrationPage extends StatelessWidget {
  const PatientRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fields = ['District', 'Block', 'Arogya Mandir', 'Village'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Patient Registration',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Demographic Info',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...fields.map(
              (field) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: field,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/personal-info');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E1F99),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Proceed',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
