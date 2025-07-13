// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateHealthRecordPage extends StatefulWidget {
  final Map<String, dynamic> patient;

  const UpdateHealthRecordPage({super.key, required this.patient});

  @override
  State<UpdateHealthRecordPage> createState() => _UpdateHealthRecordPageState();
}

class _UpdateHealthRecordPageState extends State<UpdateHealthRecordPage> {
  late TextEditingController medicalHistoryController;
  late TextEditingController currentProblemsController;
  late TextEditingController allergiesController;
  late TextEditingController currentMedicationsController;

  @override
  void initState() {
    super.initState();
    medicalHistoryController =
        TextEditingController(text: widget.patient['medicalHistory'] ?? '');
    currentProblemsController =
        TextEditingController(text: widget.patient['currentproblems'] ?? '');
    allergiesController =
        TextEditingController(text: widget.patient['allergies'] ?? '');
    currentMedicationsController =
        TextEditingController(text: widget.patient['currentmedications'] ?? '');
  }

  Future<void> updateHealthRecord() async {
    final url = Uri.parse(
        'https://karuna-backend.onrender.com/api/patients/update/${widget.patient['_id']}');

    final body = jsonEncode({
      "medicalHistory": medicalHistoryController.text,
      "currentproblems": currentProblemsController.text,
      "allergies": allergiesController.text,
      "currentmedications": currentMedicationsController.text,
    });

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Health record updated successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Health Record'),
        backgroundColor: const Color(0xFF3E1F99),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: medicalHistoryController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Medical History',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: currentProblemsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Current Problems',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: allergiesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Allergies',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: currentMedicationsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Current Medications',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: updateHealthRecord,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
