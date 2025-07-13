import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  int visitsCompleted = 0;
  int patientsTreated = 0;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchPerformanceStats();
  }

  Future<void> fetchPerformanceStats() async {
    try {
      final response = await http.get(
          Uri.parse('https://karuna-backend.onrender.com/api/performance'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!mounted) return; // ✅ Prevent setState after dispose
        setState(() {
          visitsCompleted = data['visitsCompleted'];
          patientsTreated = data['patientsTreated'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load stats');
      }
    } catch (e) {
      if (!mounted) return; // ✅ Prevent setState after dispose
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  Widget buildStatCard(String label, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF3E1F99),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Performance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF3E1F99),
        leading: const BackButton(color: Colors.white),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text("Failed to load performance stats."))
              : ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  children: [
                    buildStatCard(
                        "No. of visits completed", visitsCompleted.toString()),
                    buildStatCard(
                        "No. of patients treated", patientsTreated.toString()),
                  ],
                ),
    );
  }
}
