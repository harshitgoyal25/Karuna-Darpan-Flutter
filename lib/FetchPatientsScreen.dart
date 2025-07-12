import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FetchPatientsScreen extends StatefulWidget {
  const FetchPatientsScreen({super.key});

  @override
  State<FetchPatientsScreen> createState() => _FetchPatientsScreenState();
}

class _FetchPatientsScreenState extends State<FetchPatientsScreen> {
  List<dynamic> patients = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    fetchPatients(); // 👈 runs automatically when screen opens
  }

  Future<void> fetchPatients() async {
    setState(() {
      isLoading = true;
    });

    print("🌐 Sending GET request...");
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/api/patients/getAll'),
      );

      print("📥 Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          patients = data;
          isLoading = false;
        });
        print("✅ Patients data fetched.");
      } else {
        print("❌ Error: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("💥 Exception: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Widget buildPatientCard(Map<String, dynamic> patient) {
  //   return Card(
  //     elevation: 4,
  //     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: patient.entries.map((entry) {
  //           return Text(
  //             "${entry.key}: ${entry.value}",
  //             style: const TextStyle(fontSize: 14),
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
  Widget buildPatientCard(Map<String, dynamic> patient) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${patient['name'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Gender: ${patient['gender'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Patients"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: fetchPatients,
            child: const Text("🔄 Refresh Patient List"),
          ),
          const SizedBox(height: 20),
          if (isLoading)
            const CircularProgressIndicator()
          else if (patients.isEmpty)
            const Text("No data yet. Click the button above.")
          else
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  final patient = patients[index] as Map<String, dynamic>;
                  return buildPatientCard(patient);
                },
              ),
            ),
        ],
      ),
    );
  }
}
