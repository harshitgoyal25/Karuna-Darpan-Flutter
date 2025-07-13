import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:karuna_darpan/assistant/UpdateHealthRecordPage.dart';

class PatientDetailPage extends StatefulWidget {
  final Map<String, dynamic> patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  late Map<String, dynamic> patient;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    patient = Map<String, dynamic>.from(widget.patient);
    fetchPatientById(); // fetch updated data on page open
  }

  Future<void> fetchPatientById() async {
    final patientId = patient['_id'];
    final url = Uri.parse('http://10.0.2.2:5000/api/patients/$patientId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final updatedPatient = jsonDecode(response.body);
        setState(() {
          patient = updatedPatient;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch updated patient')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> markAsTreated() async {
    final patientId = patient['_id'];
    final url = Uri.parse('http://10.0.2.2:5000/api/patients/$patientId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient marked as treated')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete patient')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Text('Name: ${patient['name'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Age: ${patient['age'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Gender: ${patient['gender'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        const Divider(),
                        Text(
                            'Medical History: ${patient['medicalHistory'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        Text(
                            'Current Problems: ${patient['currentproblems'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Allergies: ${patient['allergies'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                        Text(
                            'Current Medications: ${patient['currentmedications'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text('Update Health Record',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateHealthRecordPage(patient: patient),
                        ),
                      );

                      if (updated == true) {
                        setState(() => isLoading = true);
                        await fetchPatientById();
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.check, color: Colors.white),
                    label: const Text('Mark as Treated',
                        style: TextStyle(color: Colors.white)),
                    onPressed: markAsTreated,
                  ),
                ],
              ),
            ),
    );
  }
}
