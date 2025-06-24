import 'package:flutter/material.dart';

class AddPatientPage extends StatelessWidget {
  const AddPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Add New Patient',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            _buildButton(
                context, 'Patient Registration', '/patient-registration'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.grey.shade100,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
