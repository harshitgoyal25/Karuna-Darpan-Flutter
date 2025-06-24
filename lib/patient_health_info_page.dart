import 'package:flutter/material.dart';

class PatientHealthInfoPage extends StatefulWidget {
  const PatientHealthInfoPage({super.key});

  @override
  State<PatientHealthInfoPage> createState() => _PatientHealthInfoPageState();
}

class _PatientHealthInfoPageState extends State<PatientHealthInfoPage> {
  final TextEditingController medicalHistoryController =
      TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Information',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabeledField('Medical History', medicalHistoryController),
            _buildLabeledField('Current Problem', symptomsController),
            _buildLabeledField('Allergies (if any)', allergiesController),
            _buildLabeledField('Current Medications', medicationsController),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1F99),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/confirmation-splash', (route) => false);
              },
              child:
                  const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
