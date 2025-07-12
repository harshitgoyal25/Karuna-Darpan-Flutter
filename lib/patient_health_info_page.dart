import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatientHealthInfoPage extends StatefulWidget {
  final Map<String, dynamic>? patientData;

  const PatientHealthInfoPage({super.key, this.patientData});

  @override
  State<PatientHealthInfoPage> createState() => _PatientHealthInfoPageState();
}

class _PatientHealthInfoPageState extends State<PatientHealthInfoPage> {
  final TextEditingController medicalHistoryController =
      TextEditingController();
  final TextEditingController currentProblemsController =
      TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Information',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        automaticallyImplyLeading:
            false, // Remove back button since this is part of registration flow
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.patientData != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3E1F99).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${widget.patientData!['name']}!',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Please provide your health information to complete your profile.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
            const Text(
              'Medical Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildLabeledField(
              'Medical History',
              medicalHistoryController,
              'Any previous surgeries, chronic conditions, family history, etc.',
            ),
            _buildLabeledField(
              'Current Health Problems',
              currentProblemsController,
              'Describe your current symptoms or health concerns',
            ),
            _buildLabeledField(
              'Allergies',
              allergiesController,
              'Food allergies, drug allergies, environmental allergies, etc.',
            ),
            _buildLabeledField(
              'Current Medications',
              medicationsController,
              'List all medications you are currently taking',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1F99),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: isLoading ? null : _submitHealthInfo,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Complete Registration',
                      style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  // Skip health info and go to confirmation
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/confirmation-splash',
                    (route) => false,
                  );
                },
                child: const Text(
                  'Skip for now',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField(
      String label, TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF3E1F99)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitHealthInfo() async {
    if (widget.patientData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient data not found')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:5000/api/patients/update/${widget.patientData!['id']}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'medicalHistory': medicalHistoryController.text.trim(),
          'currentproblems': currentProblemsController.text.trim(),
          'allergies': allergiesController.text.trim(),
          'currentmedications': medicationsController.text.trim(),
        }),
      );

      print('📥 Health Info Update Status Code: ${response.statusCode}');
      print('📥 Health Info Update Response: ${response.body}');

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Health information saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to confirmation splash
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/confirmation-splash',
          (route) => false,
        );
      } else {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Failed to save health info: ${data['message'] ?? 'Unknown error'}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("💥 Error saving health info: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
