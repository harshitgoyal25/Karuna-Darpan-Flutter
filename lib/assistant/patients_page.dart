import 'package:flutter/material.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        backgroundColor: Color(0xFF3E1F99),
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          _buildButton(context, 'Lists', '/patient-list'),
          _buildButton(context, 'Add New Patient', '/add-patient'),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Text(title, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
